import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/payment/methode_pay_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'method_payment_state.dart';

class MethodPaymentCubit extends Cubit<MethodPaymentState> {
  MethodPaymentCubit() : super(MethodPaymentInitial());

  Future<void> getAllMethodPay(BuildContext context) async {
    emit(MethodPaymentLoading());

    Future<ObjResponse> res = callNetwork(METHOD_PAYMENT);

    await res.then((value) {
      if (value.success == true) {
        debugPrint("success response is : ${value.response['data']}");

        List<MethodPayment> dataMethod = List<MethodPayment>.from(
            value.response['data'].map((x) => MethodPayment.fromJson(x)));
        emit(MethodPaymentLoaded(dataMethod));
      } else {
        debugPrint(value.response['status']['message']);
        emit(MethodPaymentError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(MethodPaymentError(e.toString()));
      }
    });
  }
}
