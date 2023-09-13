import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/detail_alamat/added_alamat_request.dart';
import 'package:katarasa/models/profile/detail_alamat/detail_alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  EditAddressCubit() : super(EditAddressInitial());

  bool isEdit = false;

  Future<void> editAddress(
      AddAlamatRequest payload, BuildContext context, int id) async {
    emit(EditAddressLoading());
    isEdit = true;
    Future<ObjResponse> res = callNetwork("${EDIT_ADDRESS}id_address=$id",
        body: payload.toMap(), mode: PUT_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success post response is : ${value.response['status']['message']}');

        emit(EditAddressSuccess(value.response['status']['message']));
      } else {
        debugPrint('error post response is : ${value.errresponse.errors}');

        emit(EditAddressError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(EditAddressError(e.toString()));
      }
    });
    isEdit = false;
  }

  Future<void> deleteAddress(int id, BuildContext context) async {
    Future<ObjResponse> res = callNetwork("${DELETE_ADDRESS}id_address=$id",
        body: {'id_address': id}, mode: DELETE_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success delete response is : ${value.response['status']['message']}');

        emit(RemoveAddressSuccess(value.response['status']['message']));
      } else {
        debugPrint('error delete response is : ${value.errresponse.errors}');

        emit(RemoveAddressError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(RemoveAddressError(e.toString()));
      }
    });
  }
}
