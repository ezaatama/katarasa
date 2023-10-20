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

final class AllOrderLoaded extends DataOrderState {
  final List<DataItem> items;

  const AllOrderLoaded(this.items);
}

final class AllOrderLoading extends DataOrderState {
  final List<DataItem> items;
  final bool isFirstFetch;

  const AllOrderLoading(this.items, {this.isFirstFetch = false});
}

final class AllOrderError extends DataOrderState {
  final String allOrderErr;

  const AllOrderError(this.allOrderErr);
}
