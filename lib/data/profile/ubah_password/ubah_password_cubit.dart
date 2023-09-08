import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/ubah_password/ubah_password_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:meta/meta.dart';

part 'ubah_password_state.dart';

class UbahPasswordCubit extends Cubit<UbahPasswordState> {
  UbahPasswordCubit() : super(UbahPasswordInitial());

  bool isUpdatePass = false;

  Future<void> updatePassProfile(
      BuildContext context, UbahPasswordRequest payload) async {
    emit(UbahPasswordLoading());
    isUpdatePass = true;
    Future<ObjResponse> res =
        callNetwork(CHANGE_PASSWORD, body: payload.toJson(), mode: PUT_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        emit(UbahPasswordSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(UbahPasswordError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(UbahPasswordError(e.toString()));
      }
    });
    isUpdatePass = false;
  }
}
