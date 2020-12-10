import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:test_color_project/core/error/error.dart';
import 'package:test_color_project/core/error/exception.dart';
import 'package:test_color_project/core/network/network_info.dart';
import 'package:test_color_project/features/color_feature/data/datasources/local_color_data_source.dart';
import 'package:test_color_project/features/color_feature/data/datasources/remote_color_data_source.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';
import 'package:test_color_project/features/color_feature/domain/repositories/color_entity_repository.dart';
import 'package:meta/meta.dart';

class ColorEntityRepositoryImpl extends ColorEntityRepository {
  final RemoteColorDataSource _remoteDataSource;
  final LocalColorDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  ColorEntityRepositoryImpl({
    @required remoteDataSource,
    @required localDataSource,
    @required networkInfo,
  })  : this._remoteDataSource = remoteDataSource,
        this._localDataSource = localDataSource,
        this._networkInfo = networkInfo,
        super();

  @override
  Future<Either<Error, ColorEntity>> getRandomColorEntity() async {
    if (await _networkInfo.isConnected && !kIsWeb) {
      try {
        final remoteColor = await _remoteDataSource.getRandomColor();
        return Right(ColorEntity(remoteColor));
      } on JsonException {
        return Left(JsonError());
      } on NetworkException {
        return Left(NetworkError());
      }
    } else {
      final localColor = _localDataSource.getRandomColor();
      return Right(ColorEntity(localColor));
    }
  }
}
