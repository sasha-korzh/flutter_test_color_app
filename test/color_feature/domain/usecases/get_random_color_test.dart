import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_color_project/core/usecases/usecase.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';
import 'package:test_color_project/features/color_feature/domain/repositories/color_entity_repository.dart';
import 'package:test_color_project/features/color_feature/domain/usecases/get_random_color_entity.dart';

class MockColorRepository extends Mock implements ColorEntityRepository {}

void main() {
  MockColorRepository mockColorRepository;
  GetRandomColorEntity usecase;

  setUp(() {
    mockColorRepository = MockColorRepository();
    usecase = GetRandomColorEntity(mockColorRepository);
  });

  final greyColor = Colors.grey;
  final tColorEntity = ColorEntity(greyColor);

  test('should get ColorEntity from the repository', () async {
    // arrange
    when(mockColorRepository.getRandomColorEntity())
        .thenAnswer((_) async => Right(tColorEntity));
    // act
    final result = await usecase(NoParam());
    // assert
    expect(result, Right(tColorEntity));
    verify(mockColorRepository.getRandomColorEntity());
    verifyNoMoreInteractions(mockColorRepository);
  });
}
