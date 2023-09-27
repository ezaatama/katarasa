part of 'data_shipping_cubit.dart';

sealed class DataShippingState extends Equatable {
  const DataShippingState();

  @override
  List<Object> get props => [];
}

final class DataShippingInitial extends DataShippingState {}

final class DataShippingLoading extends DataShippingState {}

final class DataShippingLoaded extends DataShippingState {
  final Shipping shippingLoaded;

  const DataShippingLoaded(this.shippingLoaded);
}

final class DataShippingError extends DataShippingState {
  final String errShipping;

  const DataShippingError(this.errShipping);
}

final class DataShippingEmpty extends DataShippingState {}

final class SelectShippingInitial extends DataShippingState {}

final class SelectShippingLoading extends DataShippingState {}

final class SelectShippingSuccess extends DataShippingState {
  final String selectSuccess;

  const SelectShippingSuccess(this.selectSuccess);
}

final class SelectShippingError extends DataShippingState {
  final String errSelect;

  const SelectShippingError(this.errSelect);
}
