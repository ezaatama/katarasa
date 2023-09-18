import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/products/products_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  Future<void> getAllProduct(BuildContext context) async {
    emit(ProductsLoading());

    Future<ObjResponse> res = callNetwork(
        "$ALL_PRODUCTS?page=1&limit=5&keyword=&filter_price=&filter_category=&filter_condition=&filter_preorder=&filter_brand=&filter_etalase=&sort=");

    res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success response is ${value.response['status']['message']}');

        List<ProductRequest> res = List<ProductRequest>.from(
            value.response['data'].map((x) => ProductRequest.fromJson(x)));

        emit(ProductsSuccess(res));
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
