import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/cart/cart_item_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';

part 'item_cart_state.dart';

class ItemCartCubit extends Cubit<ItemCartState> {
  ItemCartCubit() : super(ItemCartInitial());

  Future<void> addToCart(CartItemRequest payload, BuildContext context) async {
    Future<ObjResponse> res =
        callNetwork(ADD_TO_CART, body: payload.toMap(), mode: POST_METHOD);

    await res.then((value) {
      if (value.success == true) {
        if (value.success == true) {
          debugPrint(
              'ini value response message + ${value.response['status']['message']}');

          emit(ItemCartUpdated(value.response['status']['message']));
        } else {
          debugPrint(value.errresponse.errors);
          emit(ItemCartError(value.errresponse.errors));
        }
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(ItemCartError(e.toString()));
      }
    });
  }
}
