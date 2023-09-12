part of 'kecamatan_cubit.dart';

sealed class KecamatanState extends Equatable {
  const KecamatanState();

  @override
  List<Object> get props => [];
}

final class KecamatanInitial extends KecamatanState {}

final class KecamatanLoading extends KecamatanState {}

final class KecamatanLoaded extends KecamatanState {
  final List<SelectKecamatan> listKecamatan;

  const KecamatanLoaded(this.listKecamatan);

  @override
  List<Object> get props => [listKecamatan];
}

final class KecamatanError extends KecamatanState {
  final String errKec;

  const KecamatanError(this.errKec);
}
