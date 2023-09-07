part of 'forgot_pass_cubit.dart';

@immutable
sealed class ForgotPassState {}

final class ForgotPassInitial extends ForgotPassState {}

final class ForgotPassLoading extends ForgotPassState {}

final class ForgotPassSuccess extends ForgotPassState {
  final String forgotPassSuccess;

  ForgotPassSuccess(this.forgotPassSuccess);
}

final class ForgotPassError extends ForgotPassState {
  final String forgotPassErr;

  ForgotPassError(this.forgotPassErr);
}
