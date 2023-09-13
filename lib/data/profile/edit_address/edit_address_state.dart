part of 'edit_address_cubit.dart';

sealed class EditAddressState extends Equatable {
  const EditAddressState();

  @override
  List<Object> get props => [];
}

final class EditAddressInitial extends EditAddressState {}

final class EditAddressLoading extends EditAddressState {}

final class EditAddressSuccess extends EditAddressState {
  final String editSuccess;

  const EditAddressSuccess(this.editSuccess);
}

final class EditAddressError extends EditAddressState {
  final String editError;

  const EditAddressError(this.editError);
}

final class RemoveAddressSuccess extends EditAddressState {
  final String removeSucc;

  const RemoveAddressSuccess(this.removeSucc);
}

final class RemoveAddressError extends EditAddressState {
  final String removeErr;

  const RemoveAddressError(this.removeErr);
}
