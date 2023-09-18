import 'package:bloc/bloc.dart';
import 'package:katarasa/models/dummy/product_models.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  fetchProduct() {
    emit(ProductLoading());

    final res = products;

    emit(ProductSuccess(res));
  }

  ProductModels findById(String id) {
    return products.firstWhere((prod) => prod.id == id);
  }

  List<ProductModels> productItems() {
    return [...products];
  }

  List<ProductModels> favoriteProduct() {
    return products.where((element) => element.isFavorite).toList();
  }

  ProductModels toggleStatus() {
    return products
        .firstWhere((element) => element.isFavorite = !element.isFavorite);
  }

  List<ProductModels> hasiDiscountProduct() {
    return products.where((element) => element.discount != null).toList();
  }
}
