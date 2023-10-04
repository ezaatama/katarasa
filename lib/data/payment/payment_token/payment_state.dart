part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentSnapLoading extends PaymentState {}

final class PaymentSnapSuccess extends PaymentState {
  final PaySnapResponse paySnapSuccess;

  const PaymentSnapSuccess(this.paySnapSuccess);
}

final class PaymentSnapError extends PaymentState {
  final String errPaySnap;

  const PaymentSnapError(this.errPaySnap);
}
