part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModels> product;

  ProductSuccess(this.product);
}

class ProductError extends ProductState {
  final String errorProduct;

  ProductError({required this.errorProduct});
}

class ProductEmpty extends ProductState {}
