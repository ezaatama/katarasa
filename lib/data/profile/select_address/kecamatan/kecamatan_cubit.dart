import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/select_address/alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'kecamatan_state.dart';

class KecamatanCubit extends Cubit<KecamatanState> {
  KecamatanCubit() : super(KecamatanInitial());

  void resetKecamatan() {
    emit(KecamatanInitial());
  }

  Future<SelectKecamatan?> getListKecamatan(
      BuildContext context, int idKota, int idKab, String idKec) async {
    emit(KecamatanLoading());

    Future<ObjResponse> res = callNetwork(
        "${LIST_ADDRESS}province_id=$idKota&city_id=$idKab&district_kd=$idKec");

    await res.then((value) {
      if (value.success == true) {
        var kecamatan = AlamatRequest.fromJson(value.response);

        emit(KecamatanLoaded(kecamatan.data.selectKecamatan));
      } else {
        emit(KecamatanError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(KecamatanError(e.toString()));
      }
    });
    return null;
  }

  List<SelectKecamatan> getDropdownKecamatan() {
    if (state is KecamatanLoaded) {
      return (state as KecamatanLoaded).listKecamatan;
    }
    return [];
  }
}
