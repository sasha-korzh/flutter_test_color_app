part of 'color_feature_cubit.dart';

abstract class ColorFeatureState extends Equatable {
  const ColorFeatureState();
}

class ColorFeatureInitial extends ColorFeatureState {
  @override
  List<Object> get props => [];
}

class ColorFeatureLoading extends ColorFeatureState {
  @override
  List<Object> get props => [];
}

class ColorFeatureLoaded extends ColorFeatureState {
  final ColorEntity colorEntity;

  ColorFeatureLoaded(this.colorEntity);

  @override
  List<Object> get props => [colorEntity];
}

class ColorFeatureError extends ColorFeatureState {
  final String message;

  ColorFeatureError(this.message);

  @override
  List<Object> get props => [message];
}
