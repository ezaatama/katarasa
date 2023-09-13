import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/detail_alamat/added_alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial());

  bool addIsLoading = false;

  Future<void> addNewAddress(
      BuildContext context, AddAlamatRequest payload) async {
    emit(AddAddressLoading());
    addIsLoading = true;

    Future<ObjResponse> res =
        callNetwork(ADD_ADDRESS, body: payload.toMap(), mode: POST_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success post response is : ${value.response['status']['message']}');

        emit(AddAddressSuccess(value.response['status']['message']));
      } else {
        debugPrint('error post response is : ${value.errresponse.errors}');

        emit(AddAddressError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InvalidInputException) {
        showToast(text: e.toString(), state: ToastStates.ERROR);
        emit(AddAddressError(e.toString()));
      }
    });
    addIsLoading = false;
  }
}
