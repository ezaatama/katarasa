import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/products/product_detail_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:meta/meta.dart';

part 'products_detail_state.dart';

class ProductsDetailCubit extends Cubit<ProductsDetailState> {
  ProductsDetailCubit() : super(ProductsDetailInitial());

  Future<void> getDetailProduct(BuildContext context, String slug) async {
    emit(ProductsDetailLoading());

    Future<ObjResponse> res = callNetwork("$PRODUCT_DETAIL?slug=$slug");

    res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success response detail is ${value.response['status']['message']}');

        ProductDetailRequest detailProduct =
            ProductDetailRequest.fromJson(value.response['data']);

        emit(ProductsDetailSuccess(detailProduct));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        showToast(text: e.toString(), state: ToastStates.ERROR);
      } else {
        debugPrint('error responses is: ${e.toString()}');
        emit(ProductsDetailError(errDetailProds: e.toString()));
      }
    });
  }
}
