class CartItemRequest {
  final String productId;
  final String variantId;
  int quantity;
  bool isNonPhysical;

  CartItemRequest(
      {required this.productId,
      required this.variantId,
      this.quantity = 1,
      this.isNonPhysical = false});

  CartItemRequest copyWith(
      {String? productId,
      String? variantId,
      int? quantity,
      bool? isNonPhysical}) {
    return CartItemRequest(
        productId: productId ?? this.productId,
        variantId: variantId ?? this.variantId,
        quantity: quantity ?? this.quantity,
        isNonPhysical: isNonPhysical ?? this.isNonPhysical);
  }

  Map<String, dynamic> toMap() => {
        'product_id': productId,
        'variant_id': variantId,
        'qty': quantity,
        'isNonPhysical': isNonPhysical
      };

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
