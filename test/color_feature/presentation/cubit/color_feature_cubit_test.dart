import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_color_project/core/error/error.dart';
import 'package:test_color_project/core/usecases/usecase.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';
import 'package:test_color_project/features/color_feature/domain/usecases/get_random_color_entity.dart';
import 'package:test_color_project/features/color_feature/presentation/cubit/color_feature_cubit.dart';

class MockGetRandomColorEntity extends Mock implements GetRandomColorEntity {}

void main() {
  ColorFeatureCubit cubit;
  MockGetRandomColorEntity mockGetRandomColorEntity;

  setUp(() {
    mockGetRandomColorEntity = MockGetRandomColorEntity();
    cubit = ColorFeatureCubit(getRandomColorEntity: mockGetRandomColorEntity);
  });

  test('initialState should be [ColorFeatureInitial]', () {
    // assert
    expect(cubit.state, ColorFeatureInitial());
  });

  final greyColor = Colors.grey;
  final tColorEntity = ColorEntity(greyColor);

  test('''should emit [ColorFeatureError] with JSON_ERROR message
     when usecase return JsonError''', () async {
    // arrange
    when(mockGetRandomColorEntity(NoParam()))
        .thenAnswer((_) async => Left(JsonError()));
    // act
    cubit.getRandomColor();
    await untilCalled(mockGetRandomColorEntity(NoParam()));
    // assert
    final expected = ColorFeatureError(JSON_ERROR_MESSAGE);
    expectLater(cubit.state, expected);
  });

  test('''should emit [ColorFeatureError] with NETWORK_ERROR message
     when usecase return NetworkError''', () async {
    // arrange
    when(mockGetRandomColorEntity(NoParam()))
        .thenAnswer((_) async => Left(NetworkError()));
    // act
    cubit.getRandomColor();
    await untilCalled(mockGetRandomColorEntity(NoParam()));
    // assert
    final expected = ColorFeatureError(NETWORK_ERROR_MESSAGE);
    expectLater(cubit.state, expected);
  });

  test('should call the usecase', () async {
    // arrange
    when(mockGetRandomColorEntity(NoParam()))
        .thenAnswer((_) async => Right(tColorEntity));
    // act
    cubit.getRandomColor();
    await untilCalled(mockGetRandomColorEntity(any));
    // assert
    verify(mockGetRandomColorEntity(NoParam()));
  });

  test('''should emit [ColorFeatureLoaded] with [ColorEntity]
     when usecase return not error''', () async {
    // arrange
    when(mockGetRandomColorEntity(NoParam()))
        .thenAnswer((_) async => Right(tColorEntity));
    // act
    cubit.getRandomColor();
    await untilCalled(mockGetRandomColorEntity(NoParam()));
    // assert
    final expected = ColorFeatureLoaded(tColorEntity);
    expectLater(cubit.state, expected);
  });
}
