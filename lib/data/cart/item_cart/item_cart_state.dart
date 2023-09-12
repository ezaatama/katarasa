part of 'item_cart_cubit.dart';

sealed class ItemCartState extends Equatable {
  const ItemCartState();

  @override
  List<Object> get props => [];
}

final class ItemCartInitial extends ItemCartState {}

final class ItemCartUpdated extends ItemCartState {
  final String itemCartUpdated;

  const ItemCartUpdated(this.itemCartUpdated);
}

final class ItemCartError extends ItemCartState {
  final String errItemCart;

  const ItemCartError(this.errItemCart);
}
