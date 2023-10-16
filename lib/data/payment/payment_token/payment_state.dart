part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentSnapLoading extends PaymentState {}

final class PaymentSnapUpdateLoading extends PaymentState {}

final class PaymentSnapSuccess extends PaymentState {
  final PaySnapResponse paySnapSuccess;

  const PaymentSnapSuccess(this.paySnapSuccess);
}

final class PaymentSnapUpdateSuccess extends PaymentState {
  final PaySnapUpdate paySnapUpdSuccess;

  const PaymentSnapUpdateSuccess(this.paySnapUpdSuccess);
}

final class PaymentSnapError extends PaymentState {
  final String errPaySnap;

  const PaymentSnapError(this.errPaySnap);
}

final class PaymentSnapUpdateError extends PaymentState {
  final String errUpdPaySnap;

  const PaymentSnapUpdateError(this.errUpdPaySnap);
}
