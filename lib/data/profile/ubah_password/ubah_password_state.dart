part of 'ubah_password_cubit.dart';

@immutable
sealed class UbahPasswordState {}

final class UbahPasswordInitial extends UbahPasswordState {}

final class UbahPasswordLoading extends UbahPasswordState {}

final class UbahPasswordSuccess extends UbahPasswordState {
  final String updatePassSuccess;

  UbahPasswordSuccess(this.updatePassSuccess);
}

final class UbahPasswordError extends UbahPasswordState {
  final String errUpdatePass;

  UbahPasswordError(this.errUpdatePass);
}
