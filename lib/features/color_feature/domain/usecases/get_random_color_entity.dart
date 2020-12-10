import 'package:dartz/dartz.dart';
import 'package:test_color_project/core/usecases/usecase.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';
import 'package:test_color_project/features/color_feature/domain/repositories/color_entity_repository.dart';
import 'package:test_color_project/core/error/error.dart';

class GetRandomColorEntity extends UseCase<ColorEntity, NoParam> {
  final ColorEntityRepository colorEntityRepository;

  GetRandomColorEntity(this.colorEntityRepository);

  @override
  Future<Either<Error, ColorEntity>> call(param) async {
    return await colorEntityRepository.getRandomColorEntity();
  }
}
