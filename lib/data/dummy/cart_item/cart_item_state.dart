part of 'cart_item_cubit.dart';

@immutable
sealed class CartItemState {}

final class CartItemUpdated extends CartItemState {
  final List<CartItem> cartItems;

  CartItemUpdated(this.cartItems);
}

final class CartItemDetailUpdate extends CartItemState {
  final CartItem cartItem;

  CartItemDetailUpdate(this.cartItem);
}
