
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_color_project/core/error/error.dart';

// todo: describe doc
abstract class UseCase<Type, Param> {
  Future<Either<Error, Type>> call(Param param);
}

class NoParam extends Equatable {
  
  @override
  List<Object> get props => [];

}