part of 'provinsi_cubit.dart';

sealed class ProvinsiState extends Equatable {
  const ProvinsiState();

  @override
  List<Object> get props => [];
}

final class ProvinsiInitial extends ProvinsiState {}

final class ProvinsiLoading extends ProvinsiState {}

final class ProvinsiLoaded extends ProvinsiState {
  final List<SelectProvinsi> listProvinsi;

  const ProvinsiLoaded(this.listProvinsi);

  @override
  List<Object> get props => [listProvinsi];
}

final class ProvinsiError extends ProvinsiState {
  final String errProvinsi;

  const ProvinsiError(this.errProvinsi);
}
