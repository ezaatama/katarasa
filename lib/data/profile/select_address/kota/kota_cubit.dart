import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/select_address/alamat_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'kota_state.dart';

class KotaCubit extends Cubit<KotaState> {
  KotaCubit() : super(KotaInitial());

  //kota
  void resetKota() {
    emit(KotaInitial());
  }

  Future<SelectKota?> getListKota(BuildContext context, int id) async {
    emit(KotaLoading());

    Future<ObjResponse> res =
        callNetwork("${LIST_ADDRESS}province_id=$id&city_id=&district_kd=");

    await res.then((value) {
      if (value.success == true) {
        var kota = AlamatRequest.fromJson(value.response);

        emit(KotaLoaded(kota.data.selectKota));
      } else {
        emit(KotaError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(KotaError(e.toString()));
      }
    });

    return null;
  }

  List<SelectKota> getDropdownKota() {
    if (state is KotaLoaded) {
      return (state as KotaLoaded).listKota;
    }
    return [];
  }
}
