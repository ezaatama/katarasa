part of 'all_cart_cubit.dart';

sealed class AllCartState extends Equatable {
  const AllCartState();

  @override
  List<Object> get props => [];
}

final class AllCartInitial extends AllCartState {}

final class AllCartLoading extends AllCartState {}

final class AllCartLoaded extends AllCartState {
  final AllCart allCartLoaded;

  const AllCartLoaded(this.allCartLoaded);
}

final class AllCartError extends AllCartState {
  final String errAllCart;

  const AllCartError(this.errAllCart);
}

final class AllCartEmpty extends AllCartState {}
