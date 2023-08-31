part of 'products_detail_cubit.dart';

@immutable
sealed class ProductsDetailState {}

final class ProductsDetailInitial extends ProductsDetailState {}

final class ProductsDetailLoading extends ProductsDetailState {}

final class ProductsDetailSuccess extends ProductsDetailState {
  final ProductDetailRequest productsDetail;

  ProductsDetailSuccess(this.productsDetail);
}

final class ProductsDetailError extends ProductsDetailState {
  final String errDetailProds;

  ProductsDetailError({required this.errDetailProds});
}

final class ProductsDetailEmpty extends ProductsDetailState {}
