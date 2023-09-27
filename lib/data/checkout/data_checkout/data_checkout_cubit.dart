import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/checkout/checkout_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'data_checkout_state.dart';

class DataCheckoutCubit extends Cubit<DataCheckoutState> {
  DataCheckoutCubit() : super(DataCheckoutInitial());

  Future<void> getAllCheckout(BuildContext context) async {
    emit(DataCheckoutLoading());

    Future<ObjResponse> res = callNetwork(DATA_CHECKOUT);

    await res.then((value) {
      if (value.success == true) {
        debugPrint("success response is : ${value.response['data']}");

        Checkout dataCheckout = Checkout.fromJson(value.response['data']);

        if (dataCheckout.cart.isEmpty) {
          emit(DataCheckoutEmpty());
        } else {
          emit(DataCheckoutLoaded(dataCheckout));
        }
      } else {
        debugPrint(value.response['status']['message']);
        emit(DataCheckoutError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(DataCheckoutError(e.toString()));
      }
    });
  }

  bool isCheckout = false;

  Future<void> postCheckout(
      BuildContext context, AddToCheckoutRequest payload) async {
    emit(PostCheckoutLoading());
    isCheckout = true;
    Future<ObjResponse> res =
        callNetwork(ADD_TO_CHECKOUT, mode: POST_METHOD, body: payload.toJson());

    await res.then((value) {
      if (value.success == true) {
        debugPrint(value.response['status']['message']);
        emit(PostCheckoutSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(PostCheckoutError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(PostCheckoutError(e.toString()));
      }
    });
    isCheckout = false;
  }
}
