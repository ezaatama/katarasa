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

final class IncrementItemSuccess extends ItemCartState {
  final String incrementSuccess;

  const IncrementItemSuccess(this.incrementSuccess);
}

final class IncrementItemError extends ItemCartState {
  final String incrementError;

  const IncrementItemError(this.incrementError);
}

final class DecrementItemSuccess extends ItemCartState {
  final String decrementSuccess;

  const DecrementItemSuccess(this.decrementSuccess);
}

final class DecrementItemError extends ItemCartState {
  final String decrementError;

  const DecrementItemError(this.decrementError);
}
