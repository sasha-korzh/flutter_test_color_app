
import 'package:equatable/equatable.dart';

abstract class Error extends Equatable {}

class NetworkError extends Error {
  @override
  List<Object> get props => [];
}

class JsonError extends Error {
  @override
  List<Object> get props => [];
}