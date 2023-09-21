part of 'data_checkout_cubit.dart';

sealed class DataCheckoutState extends Equatable {
  const DataCheckoutState();

  @override
  List<Object> get props => [];
}

final class DataCheckoutInitial extends DataCheckoutState {}

final class DataCheckoutLoading extends DataCheckoutState {}

final class DataCheckoutLoaded extends DataCheckoutState {
  final Checkout checkoutLoaded;

  const DataCheckoutLoaded(this.checkoutLoaded);
}

final class DataCheckoutError extends DataCheckoutState {
  final String errCheckout;

  const DataCheckoutError(this.errCheckout);
}

final class DataCheckoutEmpty extends DataCheckoutState {}
