import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/order/order_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'data_order_state.dart';

class DataOrderCubit extends Cubit<DataOrderState> {
  DataOrderCubit() : super(DataOrderInitial());

  Future<void> getAllOrder(BuildContext context) async {
    emit(DataOrderLoading());

    Future<ObjResponse> res =
        callNetwork("${DATA_ORDER}page=1&limit=10&status=");

    await res.then((value) {
      if (value.success == true) {
        debugPrint("success response is : ${value.response['data']}");

        DataOrder dataOrder = DataOrder.fromJson(value.response['data']);

        if (dataOrder.items.isEmpty) {
          emit(DataOrderEmpty());
        } else {
          emit(DataOrderLoaded(dataOrder));
        }
      } else {
        debugPrint(value.errresponse.errors);
        emit(DataOrderError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(DataOrderError(e.toString()));
      }
    });
  }
}
