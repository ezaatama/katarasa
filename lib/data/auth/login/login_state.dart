part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String successLogin;

  LoginSuccess(this.successLogin);
}

final class LoginError extends LoginState {
  final String errLogin;

  LoginError(this.errLogin);
}
