part of 'method_payment_cubit.dart';

sealed class MethodPaymentState extends Equatable {
  const MethodPaymentState();

  @override
  List<Object> get props => [];
}

final class MethodPaymentInitial extends MethodPaymentState {}

final class MethodPaymentLoading extends MethodPaymentState {}

final class MethodPaymentLoaded extends MethodPaymentState {
  final List<MethodPayment> methodLoaded;

  const MethodPaymentLoaded(this.methodLoaded);
}

final class MethodPaymentError extends MethodPaymentState {
  final String errMethod;

  const MethodPaymentError(this.errMethod);
}
