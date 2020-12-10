import 'package:dartz/dartz.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';
import 'package:test_color_project/core/error/error.dart';

abstract class ColorEntityRepository {
  Future<Either<Error, ColorEntity>> getRandomColorEntity();
}
