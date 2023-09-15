import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/cart/all_cart_request.dart';
import 'package:katarasa/models/cart/cart_item_request.dart';
import 'package:katarasa/models/products/product_detail_request.dart';
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/endpoints.dart';
import 'package:katarasa/utils/exception.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/utils/network.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';

part 'item_cart_state.dart';

class ItemCartCubit extends Cubit<ItemCartState> {
  ItemCartCubit() : super(ItemCartUpdated([], ''));

  List<CartItemRequest> cartItems = [];

  Future<void> addToCart(ProductDetailRequest payload, String variantId,
      BuildContext context) async {
    Future<ObjResponse> res =
        callNetwork(ADD_TO_CART, body: payload.toMap(), mode: POST_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        final index = cartItems.indexWhere((e) => e.productId == payload.id);
        debugPrint('add to cart index == $index');

        if (index != -1) {
          cartItems[index] = CartItemRequest(
              productId: payload.id,
              variantId: variantId,
              quantity: cartItems[index].quantity + 1);
          Navigator.pop(context);
          showToast(
              text: "Item berhasil ditambah ke keranjang",
              state: ToastStates.SUCCESS);
          Navigator.pushNamed(context, '/all-cart');
        } else {
          cartItems.add(CartItemRequest(
              productId: payload.id, variantId: variantId, quantity: 1));
        }

        emit(ItemCartUpdated(cartItems, value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(ItemCartError(value.errresponse.errors));
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

  Future<void> incrementCartItem(String productId, String variantId,
      int quantity, BuildContext context) async {
    Future<ObjResponse> res = callNetwork(UPDATE_QTY_CART,
        body: {
          "product_id": productId,
          "variant_id": variantId,
          "qty": quantity
        },
        mode: PUT_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        emit(IncrementItemSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(IncrementItemError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        // emit(ItemCartError(e.toString()));
        emit(IncrementItemError(e.toString()));
      }
    });
  }

  Future<void> decrementCartItem(String productId, String variantId,
      int quantity, BuildContext context) async {
    Future<ObjResponse> res = callNetwork(UPDATE_QTY_CART,
        body: {
          "product_id": productId,
          "variant_id": variantId,
          "qty": quantity
        },
        mode: PUT_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        emit(DecrementItemSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(DecrementItemError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(DecrementItemError(e.toString()));
      }
    });
  }

  Future<void> setSelectItem(BuildContext context, String cartId) async {
    Future<ObjResponse> res =
        callNetwork(SELECTED_CART, body: {'cart_id': cartId}, mode: PUT_METHOD);

    await res.then((value) {
      if (value.success == true) {
        debugPrint(
            'ini value response message + ${value.response['status']['message']}');

        emit(SelectedItemSuccess(value.response['status']['message']));
      } else {
        debugPrint(value.errresponse.errors);
        emit(SelectedItemError(value.errresponse.errors));
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(SelectedItemError(e.toString()));
      }
    });
  }

  Future<void> deleteItemCart(BuildContext context, String cartId) async {
    Future<ObjResponse> res = callNetwork("${DELETE_CART}cart_id=$cartId",
        body: {'cart_id': cartId}, mode: POST_METHOD);

    await res.then((value) {
      if (value.success == true) {
        if (value.success == true) {
          debugPrint(
              'ini value response message + ${value.response['status']['message']}');

          emit(DeleteItemSuccess(value.response['status']['message']));
        } else {
          debugPrint(value.errresponse.errors);
          emit(DeleteItemError(value.errresponse.errors));
        }
      }
    }).catchError((e) {
      if (e is ConnectionProblemException || e is TimeoutException) {
        callShowSnackbar(context, e.toString());
      } else if (e is InternalServerException) {
        callShowSnackbar(context, e.toString());
      } else {
        debugPrint('error response is ${e.toString()}');
        emit(DeleteItemError(e.toString()));
      }
    });
  }
}
