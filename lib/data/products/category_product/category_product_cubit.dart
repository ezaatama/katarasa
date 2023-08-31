import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/products/categories_request.dart';
import 'package:katarasa/models/products/products_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:meta/meta.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  CategoryProductCubit() : super(CategoryProductInitial());

  Future<void> selectedCategory(BuildContext context) async {
    emit(CategoryProductInitial());
    emit(CategoryProductLoading());

    Future<ObjResponse> res = callNetwork(CATEGORIES);

    res.then((value) {
      if (value.success == true) {
        // List<ProductRequest> products = [];
        List<CategoriesRequest> products = List<CategoriesRequest>.from(
            value.response['data'].map((x) => CategoriesRequest.fromJson(x)));
        Map<String, List<CategoriesRequest>> mappedProducts =
            groupBy(products, (CategoriesRequest product) => product.name);
        List<String> categories = mappedProducts.keys.toList();

        emit(CategoryProductSelected(categories));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        showToast(text: e.toString(), state: ToastStates.ERROR);
      }
    });
  }
}
