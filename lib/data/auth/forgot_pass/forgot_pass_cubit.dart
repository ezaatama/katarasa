import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/auth/forgot_pass/forgot_password_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:meta/meta.dart';

part 'forgot_pass_state.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  ForgotPassCubit() : super(ForgotPassInitial());

  bool isForgot = false;

  Future<void> credsForgotPass(
      ForgotPasswordRequest payload, BuildContext context) async {
    emit(ForgotPassInitial());
    isForgot = true;

    Future<ObjResponse> res =
        callNetwork(FORGOT_PASSWORD, mode: POST_METHOD, body: payload.toMap());

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        emit(ForgotPassSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(ForgotPassError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(ForgotPassError(e.toString()));
      }
    });
    isForgot = false;
  }
}
