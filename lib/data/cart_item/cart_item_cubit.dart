import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/models/product_models.dart';
import 'package:meta/meta.dart';

part 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(CartItemUpdated([]));

  List<CartItem> cartItems = [];

  void addToCart(ProductModels product) {
    int index =
        cartItems.indexWhere((element) => element.product.id == product.id);
    debugPrint('add to cart index == $index');
    if (index != -1) {
      cartItems[index] =
          CartItem(product: product, quantity: cartItems[index].quantity + 1);
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
    emit(CartItemUpdated(cartItems));
  }

  void incrementCartItem(CartItem product) {
    int index = cartItems.indexWhere((element) {
      debugPrint('element product id index == ${element.product.id}');
      debugPrint('product id index == ${product.product.id}');

      return element.product.id == product.product.id;
    });

    debugPrint('increment index == $index');
    if (index != -1) {
      cartItems[index].incrementQuantity();
    }
    emit(CartItemUpdated(cartItems));
  }

  void decrementCartItem(CartItem product) {
    int index = cartItems
        .indexWhere((element) => element.product.id == product.product.id);
    debugPrint('decrement index == $index');
    if (index != -1) {
      cartItems[index].decrementQuantity();
      emit(CartItemUpdated(cartItems));
    }
  }

  void clearItem(CartItem product) {
    int index = cartItems
        .indexWhere((element) => element.product.id == product.product.id);
    debugPrint('decrement index == $index');
    if (index != -1) {
      cartItems.remove(product);
      emit(CartItemUpdated(cartItems));
    }
  }
}
