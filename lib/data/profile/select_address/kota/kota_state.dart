part of 'kota_cubit.dart';

sealed class KotaState extends Equatable {
  const KotaState();

  @override
  List<Object> get props => [];
}

final class KotaInitial extends KotaState {}

final class KotaLoading extends KotaState {}

final class KotaLoaded extends KotaState {
  final List<SelectKota> listKota;

  const KotaLoaded(this.listKota);

  @override
  List<Object> get props => [listKota];
}

final class KotaError extends KotaState {
  final String errKota;

  const KotaError(this.errKota);
}
