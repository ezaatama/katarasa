import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/select_address/alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'kabupaten_state.dart';

class KabupatenCubit extends Cubit<KabupatenState> {
  KabupatenCubit() : super(KabupatenInitial());

  void resetKabupaten() {
    emit(KabupatenInitial());
  }

  Future<SelectKabupaten?> getListKabupaten(
      BuildContext context, int idKota, int idKab) async {
    emit(KabupatenLoading());

    Future<ObjResponse> res = callNetwork(
        "${LIST_ADDRESS}province_id=$idKota&city_id=$idKab&district_kd=");

    await res.then((value) {
      if (value.success == true) {
        var kabupaten = AlamatRequest.fromJson(value.response);

        emit(KabupatenLoaded(kabupaten.data.selectKabupaten));
      } else {
        emit(KabupatenError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(KabupatenError(e.toString()));
      }
    });
    return null;
  }

  List<SelectKabupaten> getDropdownKabupaten() {
    if (state is KabupatenLoaded) {
      return (state as KabupatenLoaded).listKabupaten;
    }
    return [];
  }
}
