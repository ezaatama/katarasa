import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/checkout/shipping_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'data_shipping_state.dart';

class DataShippingCubit extends Cubit<DataShippingState> {
  DataShippingCubit() : super(DataShippingInitial());

  Future<void> getDataShipping(BuildContext context) async {
    emit(DataShippingLoading());

    Future<ObjResponse> res = callNetwork(DATA_SHIPPING);

    await res.then((value) {
      if (value.success == true) {
        debugPrint("success response is : ${value.response['data']}");

        Shipping dataShipping = Shipping.fromJson(value.response['data']);

        if (dataShipping.items.isEmpty) {
          emit(DataShippingEmpty());
        } else {
          emit(DataShippingLoaded(dataShipping));
        }
      } else {
        debugPrint(value.response['status']['message']);
        emit(DataShippingError(value.response['status']['message']));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(DataShippingError(e.toString()));
      }
    });
  }
}
