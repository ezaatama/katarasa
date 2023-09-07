import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/auth/register/register_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  bool isRegist = false;

  Future<void> credsRegist(
      RegisterRequest payload, BuildContext context) async {
    emit(RegisterInitial());
    isRegist = true;
    Future<ObjResponse> res =
        callNetwork(REGISTER, mode: POST_METHOD, body: payload.toMap());

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        emit(RegisterSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(RegisterError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(RegisterError(e.toString()));
      }
    });
    isRegist = false;
  }
}
