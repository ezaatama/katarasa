import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/payment/payment_snap_before_token.dart';
import 'package:katarasa/models/payment/payment_snap_update.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> postPaySnapToken(BuildContext context,
      PaySnapBeforeToken payload, String orderId, String isFirst) async {
    emit(PaymentSnapLoading());

    Future<ObjResponse> res = callNetwork(
        "${PAYMENT_SNAP_TOKEN}order_id=$orderId&isFirstMethod=$isFirst",
        mode: POST_METHOD,
        body: payload.toJson());

    await res.then((value) {
      if (value.success == true) {
        PaySnapResponse response =
            PaySnapResponse.fromJson(value.response['data']);
        emit(PaymentSnapSuccess(response));
      } else {
        debugPrint(value.errresponse.errors);
        emit(PaymentSnapError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(PaymentSnapError(e.toString()));
      }
    });
  }

  Future<void> postPaySnapUpdate(
      BuildContext context, PaySnapUpdateData payload) async {
    emit(PaymentSnapUpdateLoading());

    Future<ObjResponse> res = callNetwork(PAYMENT_SNAP_TOKEN_UPDATE,
        mode: POST_METHOD, body: payload.toJson());

    await res.then((value) {
      if (value.success == true) {
        PaySnapUpdate response = PaySnapUpdate.fromJson(value.response['data']);
        emit(PaymentSnapUpdateSuccess(response));
      } else {
        debugPrint(value.errresponse.errors);
        emit(PaymentSnapUpdateError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(PaymentSnapUpdateError(e.toString()));
      }
    });
  }
}
