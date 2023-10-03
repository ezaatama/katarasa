part of 'detail_order_cubit.dart';

sealed class DetailOrderState extends Equatable {
  const DetailOrderState();

  @override
  List<Object> get props => [];
}

final class DetailOrderInitial extends DetailOrderState {}

final class DetailOrderLoading extends DetailOrderState {}

final class DetailOrderLoaded extends DetailOrderState {
  final DetailOrder detailOrderLoaded;

  const DetailOrderLoaded(this.detailOrderLoaded);
}

final class DetailOrderError extends DetailOrderState {
  final String detailOrderErr;

  const DetailOrderError(this.detailOrderErr);
}
