part of 'kabupaten_cubit.dart';

sealed class KabupatenState extends Equatable {
  const KabupatenState();

  @override
  List<Object> get props => [];
}

final class KabupatenInitial extends KabupatenState {}

final class KabupatenLoading extends KabupatenState {}

final class KabupatenLoaded extends KabupatenState {
  final List<SelectKabupaten> listKabupaten;

  @override
  List<Object> get props => [listKabupaten];

  const KabupatenLoaded(this.listKabupaten);
}

final class KabupatenError extends KabupatenState {
  final String errKab;

  const KabupatenError(this.errKab);
}
