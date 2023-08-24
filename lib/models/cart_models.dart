import 'package:katarasa/models/product_models.dart';

class CartItem {
  final ProductModels product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({
    ProductModels? product,
    int? quantity,
  }) {
    return CartItem(
        product: product ?? this.product, quantity: quantity ?? this.quantity);
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
