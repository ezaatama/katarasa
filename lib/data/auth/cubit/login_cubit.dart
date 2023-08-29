import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/auth/login/login_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool isLogin = false;

  Future<void> credsLogin(LoginRequest payload, BuildContext context) async {
    emit(LoginInitial());
    isLogin = true;
    Future<ObjResponse> res =
        callNetwork(LOGIN, mode: POST_METHOD, body: payload.toMap());
    await res.then((value) {
      if (value.success == true) {
        debugPrint('ini print token + ${value.response['token']}');
        emit(LoginSuccess(value.response['token']));
      } else {
        debugPrint(value.errresponse.message);
        emit(LoginError(value.errresponse.message));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(LoginError(e.toString()));
      }
    });
    isLogin = false;
  }
}
