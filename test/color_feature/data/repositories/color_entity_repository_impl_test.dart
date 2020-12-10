import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_color_project/core/error/error.dart';
import 'package:test_color_project/core/error/exception.dart';
import 'package:test_color_project/core/network/network_info.dart';
import 'package:test_color_project/features/color_feature/data/datasources/local_color_data_source.dart';
import 'package:test_color_project/features/color_feature/data/datasources/remote_color_data_source.dart';
import 'package:test_color_project/features/color_feature/data/repositories/color_entity_repository_impl.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';

class MockRemoteColorDataSource extends Mock implements RemoteColorDataSource {}

class MockLocalColorDataSource extends Mock implements LocalColorDataSource {}

class MockNetworkInfoImpl extends Mock implements NetworkInfo {}

void main() {
  ColorEntityRepositoryImpl colorRepositoryImpl;
  MockRemoteColorDataSource remoteDataSource;
  MockLocalColorDataSource localDataSource;
  MockNetworkInfoImpl networkInfoImpl;

  setUp(() {
    remoteDataSource = MockRemoteColorDataSource();
    localDataSource = MockLocalColorDataSource();
    networkInfoImpl = MockNetworkInfoImpl();

    colorRepositoryImpl = ColorEntityRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfoImpl,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfoImpl.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfoImpl.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getRandomColor', () {
    test('should check if the device is online', () async {
      // arrange
      when(networkInfoImpl.isConnected).thenAnswer((_) async => true);
      // act
      colorRepositoryImpl.getRandomColorEntity();
      // assert
      verify(networkInfoImpl.isConnected);
    });

    final tColor = Colors.grey;
    final tColorEntity = ColorEntity(tColor);

    runTestOnline(() {
      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // arrange
        when(remoteDataSource.getRandomColor()).thenAnswer((_) async => tColor);
        // act
        final result = await colorRepositoryImpl.getRandomColorEntity();
        // assert
        expect(result, Right(tColorEntity));
        verify(remoteDataSource.getRandomColor());
      });

      test(
          'should return [NetworkError] when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(remoteDataSource.getRandomColor()).thenThrow(NetworkException());
        // act
        final result = await colorRepositoryImpl.getRandomColorEntity();
        // assert
        expect(result, equals(Left(NetworkError())));
        verifyZeroInteractions(localDataSource);
        verify(remoteDataSource.getRandomColor());
      });
    });

    runTestOffline(() {
      test(
          'should return local data when call to remote data source is unsuccessful',
          () async {
        // arrange
        when(localDataSource.getRandomColor()).thenReturn(tColor);
        // act
        final result = await colorRepositoryImpl.getRandomColorEntity();
        // assert
        expect(result, equals(Right(tColorEntity)));
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getRandomColor());
      });
    });
  });
}
