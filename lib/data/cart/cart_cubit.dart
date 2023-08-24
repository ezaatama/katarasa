import 'package:bloc/bloc.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/models/product_models.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Map<String, CartItem> items = {};

  void addItem(ProductModels product) {
    if (items.containsKey(product.id)) {
      items.update(product.id, (value) {
        return CartItem(product: product, quantity: value.quantity + 1);
      });
    } else {
      items.putIfAbsent(product.id, () => CartItem(product: product));
    }
    emit(CartUpdated(items));
  }

  void incrementCartItem(ProductModels product) {
    items.update(product.id, (value) {
      return CartItem(product: product, quantity: value.quantity + 1);
    });
    emit(CartUpdated(items));
  }

  void decrementCartItem(ProductModels product) {
    items.update(product.id, (value) {
      return CartItem(product: product, quantity: value.quantity - 1);
    });
    emit(CartUpdated(items));
  }
}
