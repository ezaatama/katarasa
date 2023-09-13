part of 'add_address_cubit.dart';

sealed class AddAddressState extends Equatable {
  const AddAddressState();

  @override
  List<Object> get props => [];
}

final class AddAddressInitial extends AddAddressState {}

final class AddAddressLoading extends AddAddressState {}

final class AddAddressSuccess extends AddAddressState {
  final String addAdrsSucc;

  const AddAddressSuccess(this.addAdrsSucc);
}

final class AddAddressError extends AddAddressState {
  final String addAdrsErr;

  const AddAddressError(this.addAdrsErr);
}
