part of 'data_order_cubit.dart';

sealed class DataOrderState extends Equatable {
  const DataOrderState();

  @override
  List<Object> get props => [];
}

final class DataOrderInitial extends DataOrderState {}

final class DataOrderLoading extends DataOrderState {}

final class DataOrderLoaded extends DataOrderState {
  final DataOrder dataOrderLoaded;

  const DataOrderLoaded(this.dataOrderLoaded);
}

final class DataOrderError extends DataOrderState {
  final String dataOrderErr;

  const DataOrderError(this.dataOrderErr);
}

final class DataOrderEmpty extends DataOrderState {}
