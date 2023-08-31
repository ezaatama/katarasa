part of 'category_product_cubit.dart';

@immutable
sealed class CategoryProductState {}

final class CategoryProductInitial extends CategoryProductState {}

final class CategoryProductLoading extends CategoryProductState {}

final class CategoryProductSelected extends CategoryProductState {
  final List<String> categories;

  CategoryProductSelected(this.categories);

  @override
  List<Object> get props => [
        categories,
      ];
}
