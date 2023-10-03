import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/order/detail_order_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

part 'detail_order_state.dart';

class DetailOrderCubit extends Cubit<DetailOrderState> {
  DetailOrderCubit() : super(DetailOrderInitial());

  Future<void> getDetailOrder(BuildContext context, String idOrder) async {
    emit(DetailOrderLoading());

    Future<ObjResponse> res = callNetwork("${DETAIL_ORDER}order_id=$idOrder");

    res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success response detail is ${value.response['status']['message']}');

        DetailOrder detailOrder = DetailOrder.fromJson(value.response['data']);

        emit(DetailOrderLoaded(detailOrder));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        showToast(text: e.toString(), state: ToastStates.ERROR);
      } else {
        debugPrint('error responses is: ${e.toString()}');
        emit(DetailOrderError(e.toString()));
      }
    });
  }
}
