import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/profile/data_profile/data_profile_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  bool isUpdateDataDiri = false;
  Future<void> postDataProfile(
      UpdateProfileRequest payload, BuildContext context) async {
    isUpdateDataDiri = true;
    Future<ObjResponse> res = callNetwork(EDIT_DATA_PROFILE,
        body: payload.toJson(), mode: PUT_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'success post response is : ${value.response['status']['message']}');

        emit(ProfileUpdated(value.response['status']['message']));
      } else {
        debugPrint('error post response is : ${value.errresponse.errors}');

        emit(ProfileError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InvalidInputException) {
        showToast(text: e.toString(), state: ToastStates.ERROR);
        emit(ProfileError(e.toString()));
      }
    });
    isUpdateDataDiri = false;
    // await getDataProfile(context);
  }

  Future<void> getDataProfile(BuildContext context) async {
    emit(ProfileLoading());
    Future<ObjResponse> res = callNetwork(DATA_PROFILE);

    await res.then((value) {
      if (value.success == true) {
        debugPrint("success response is : ${value.response['data']}");

        DataProfileRequest dataProfile =
            DataProfileRequest.fromJson(value.response['data']);

        emit(ProfileLoaded(dataProfile));
      } else {
        debugPrint(value.errresponse.errors);
        emit(ProfileError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(ProfileError(e.toString()));
      }
    });
  }
}
