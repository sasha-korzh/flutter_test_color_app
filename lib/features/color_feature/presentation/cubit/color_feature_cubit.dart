import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_color_project/core/usecases/usecase.dart';
import 'package:test_color_project/features/color_feature/domain/entities/color_entity.dart';
import 'package:test_color_project/features/color_feature/domain/usecases/get_random_color_entity.dart';
import 'package:meta/meta.dart';
import 'package:test_color_project/core/error/error.dart';

part 'color_feature_state.dart';

const String NETWORK_ERROR_MESSAGE =
    'server error, you can turn off your internet and try again with local generator.';
const String JSON_ERROR_MESSAGE =
    'not valid JSON in responce. Try to tap again.';

class ColorFeatureCubit extends Cubit<ColorFeatureState> {
  final GetRandomColorEntity getRandomColorEntity;

  ColorFeatureCubit({@required getRandomColorEntity})
      : assert(getRandomColorEntity != null),
        this.getRandomColorEntity = getRandomColorEntity,
        super(ColorFeatureInitial());

  getRandomColor() async {
    emit(ColorFeatureLoading());
    final errorOrColorEntity = await getRandomColorEntity(NoParam());
    emit(errorOrColorEntity.fold((l) => ColorFeatureError(_mapErrorMessage(l)),
        (r) => ColorFeatureLoaded(r)));
  }

  String _mapErrorMessage(Error error) {
    switch (error.runtimeType) {
      case NetworkError:
        return NETWORK_ERROR_MESSAGE;
      case JsonError:
        return JSON_ERROR_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
