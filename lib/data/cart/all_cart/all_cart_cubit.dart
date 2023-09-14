import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/cart/all_cart_request.dart';
import 'package:katarasa/models/cart/cart_item_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'all_cart_state.dart';

class AllCartCubit extends Cubit<AllCartState> {
  AllCartCubit() : super(AllCartInitial());

  List<CartItemRequest> cartItems = [];

  Future<void> getAllCart(BuildContext context) async {
    emit(AllCartLoading());

    Future<ObjResponse> res = callNetwork("$ALL_CART?page=&limit=&is_gift=");

    await res.then((value) {
      if (value.success == true) {
        debugPrint("success response is : ${value.response['data']}");

        AllCart dataProfile = AllCart.fromJson(value.response['data']);

        if (dataProfile.items.isEmpty) {
          emit(AllCartEmpty());
        } else {
          emit(AllCartLoaded(dataProfile));
        }
      } else {
        debugPrint(value.errresponse.errors);
        emit(AllCartError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(AllCartError(e.toString()));
      }
    });
  }
}
