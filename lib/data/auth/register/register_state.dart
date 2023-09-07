part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String registSuccess;

  RegisterSuccess(this.registSuccess);
}

final class RegisterError extends RegisterState {
  final String registError;

  RegisterError(this.registError);
}
