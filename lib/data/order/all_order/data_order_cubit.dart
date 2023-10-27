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

  int currentPage = 1;
  int itemPerPage = 10;
  bool isFirstLoading = false;
  bool hasNextPage = false;
  bool isLoadMore = false;
  bool isEndList = false;
  List<DataItem> items = [];

  Future<void> fetchOrder(BuildContext context, String filters) async {
    isFirstLoading = true;

    Future<ObjResponse> res = callNetwork(
        "${DATA_ORDER}page=$currentPage&limit=$itemPerPage&status=$filters");

    await res.then((value) {
      if (value.success == true) {
        DataOrderResponse dataOrder =
            DataOrderResponse.fromJson(value.response);

        if (dataOrder.data.items.isEmpty) {
          emit(DataOrderEmpty());
        } else {
          items = dataOrder.data.items;
          // emit(AllOrderLoaded(items));
        }
      } else {
        debugPrint(value.errresponse.errors);

        emit(AllOrderError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(AllOrderError(e.toString()));
      }
    });

    isFirstLoading = false;
    isLoadMore = false;
  }

  void loadMoreOrder(BuildContext context, String filters) async {
    // isFirstLoading = false;
    // hasNextPage = true;
    // !isEndList;
    // isLoadMore = false;

    isLoadMore = true;

    currentPage++;

    Future<ObjResponse> res = callNetwork(
        "${DATA_ORDER}page=$currentPage&limit=$itemPerPage&status=$filters");

    await res.then((value) {
      if (value.success == true) {
        DataOrderResponse dataOrder =
            DataOrderResponse.fromJson(value.response);

        if (value.errresponse.status.code != 200) {
          hasNextPage = false;
          items = [];
          emit(DataOrderEmpty());
        } else {
          items.addAll(dataOrder.data.items);

          if (currentPage >= dataOrder.data.totalPage) {
            currentPage = currentPage - 1;
            isEndList = true;
          } else {
            hasNextPage = false;
          }
          emit(AllOrderLoaded(items));
        }
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(AllOrderError(e.toString()));
      }
    });
    isLoadMore = false;
  }

  Future<void> fetchFilter(BuildContext context, String filters) async {
    Future<ObjResponse> res = callNetwork(
        "${DATA_ORDER}page=$currentPage&limit=$itemPerPage&status=$filters");
    await res.then((value) {
      if (value.success == true) {
        DataOrderResponse dataOrder =
            DataOrderResponse.fromJson(value.response);

        if (dataOrder.data.items.isEmpty) {
          emit(DataOrderEmpty());
        } else {
          items = dataOrder.data.items;
          emit(AllOrderLoaded(items));
        }
      } else {
        debugPrint(value.errresponse.errors);

        emit(AllOrderError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(AllOrderError(e.toString()));
      }
    });
    isLoadMore = false;
  }
}
