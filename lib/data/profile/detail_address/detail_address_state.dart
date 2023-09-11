part of 'detail_address_cubit.dart';

@immutable
sealed class DetailAddressState {}

final class DetailAddressInitial extends DetailAddressState {}

final class DetailAddressLoading extends DetailAddressState {}

final class DetailAddressLoaded extends DetailAddressState {
  List<dynamic> detailAlamat;

  DetailAddressLoaded(this.detailAlamat);
}

final class DetailAddressError extends DetailAddressState {
  final String detailAdrError;

  DetailAddressError(this.detailAdrError);
}

final class DetailAddressEmpty extends DetailAddressState {}
