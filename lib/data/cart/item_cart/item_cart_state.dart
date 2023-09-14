part of 'item_cart_cubit.dart';

sealed class ItemCartState extends Equatable {
  const ItemCartState();

  @override
  List<Object> get props => [];
}

final class ItemCartInitial extends ItemCartState {}

final class ItemCartUpdated extends ItemCartState {
  final List<CartItemRequest> itemCartUpdated;
  final String cartUpdated;

  const ItemCartUpdated(this.itemCartUpdated, this.cartUpdated);
}

final class ItemCartError extends ItemCartState {
  final String errItemCart;

  const ItemCartError(this.errItemCart);
}

final class SelectedItemSuccess extends ItemCartState {
  final String selectSuccess;

  const SelectedItemSuccess(this.selectSuccess);
}

final class SelectedItemError extends ItemCartState {
  final String selectError;

  const SelectedItemError(this.selectError);
}

final class DeleteItemSuccess extends ItemCartState {
  final String deleteSuccess;

  const DeleteItemSuccess(this.deleteSuccess);
}

final class DeleteItemError extends ItemCartState {
  final String deleteError;

  const DeleteItemError(this.deleteError);
}
