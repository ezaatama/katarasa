import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/select_address/alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'provinsi_state.dart';

class ProvinsiCubit extends Cubit<ProvinsiState> {
  ProvinsiCubit() : super(ProvinsiInitial());

  //provinsi
  Future<SelectProvinsi?> getListProvince(BuildContext context) async {
    emit(ProvinsiLoading());

    Future<ObjResponse> res =
        callNetwork("${LIST_ADDRESS}province_id=&city_id=&district_kd=");

    await res.then((value) {
      if (value.success == true) {
        var provinsi = AlamatRequest.fromJson(value.response);

        emit(ProvinsiLoaded(provinsi.data.selectProvinsi));
      } else {
        emit(ProvinsiError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(ProvinsiError(e.toString()));
      }
    });
    return null;
  }

  List<SelectProvinsi> getDropdownProvinsi() {
    if (state is ProvinsiLoaded) {
      return (state as ProvinsiLoaded).listProvinsi;
    }
    return [];
  }
}
