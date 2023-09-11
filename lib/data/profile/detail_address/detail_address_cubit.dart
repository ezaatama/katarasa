import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/detail_alamat/detail_alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:meta/meta.dart';

part 'detail_address_state.dart';

class DetailAddressCubit extends Cubit<DetailAddressState> {
  DetailAddressCubit() : super(DetailAddressInitial());

  Future<void> getListAddress(
    BuildContext context,
  ) async {
    emit(DetailAddressLoading());
    Future<ObjResponse> res = callNetwork(DETAIL_ADDRESS);

    await res.then((value) {
      if (value.success == true) {
        var data = DetailAlamatRequest.fromJson(value.response);
        if (data.data.isNotEmpty) {
          emit(DetailAddressLoaded(data.data));
        } else {
          emit(DetailAddressEmpty());
        }
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(DetailAddressError(e.toString()));
      }
    });
  }
}
