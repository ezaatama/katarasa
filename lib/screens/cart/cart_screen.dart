import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart_item/cart_item_cubit.dart';
import 'package:katarasa/models/cart_models.dart';
import 'package:katarasa/models/product_models.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/cart_product.dart';
import 'package:katarasa/widgets/disable_button.dart';
import 'package:katarasa/widgets/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUI.WHITE,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: ColorUI.BLACK,
              size: 22,
            )),
        title: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .050,
              height: MediaQuery.of(context).size.height * .025,
              decoration: BoxDecoration(
                  border: Border.all(color: ColorUI.MEDIUM_BROWN, width: 3),
                  borderRadius: BorderRadius.circular(100)),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pickup",
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontSize: 16, fontWeight: FontUI.WEIGHT_BOLD),
                ),
                Text(
                  "Pesan dan ambil di outlet",
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontSize: 14, fontWeight: FontUI.WEIGHT_LIGHT),
                )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 15, right: 16),
                  child: BlocBuilder<CartItemCubit, CartItemState>(
                      builder: (context, state) {
                    if (state is CartItemUpdated) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * .700,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.cartItems.length,
                                itemBuilder: (context, index) {
                                  CartItem product = state.cartItems[index];
                                  CartItem cartItem = state.cartItems
                                      .firstWhere(
                                          (item) =>
                                              item.product.id ==
                                              product.product.id,
                                          orElse: () => CartItem(
                                              product: product.product,
                                              quantity: 1));
                                  // print(cartItem.quantity);
                                  return CartProductItem(
                                    product: state.cartItems[index],
                                    decrementItem: () {
                                      context
                                          .read<CartItemCubit>()
                                          .decrementCartItem(product);
                                      debugPrint('decrement');
                                    },
                                    quantityItem: cartItem.quantity.toString(),
                                    incrementItem: () {
                                      context
                                          .read<CartItemCubit>()
                                          .incrementCartItem(product);
                                      debugPrint('increment');
                                    },
                                    clearItem: () {
                                      context
                                          .read<CartItemCubit>()
                                          .clearItem(product);
                                      debugPrint('delete');
                                    },
                                  );
                                }),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.arrow_back_ios_new_rounded,
                                      color: ColorUI.BROWN, size: 18),
                                  Text(
                                    "Tambah Pesanan",
                                    style: BROWN_TEXT_STYLE.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(thickness: 2, height: 2),
                            const SizedBox(height: 10),
                            Text(
                              "*Kami buka mulai dari pukul 11.00 - 19.00 WIB",
                              style: BLACK_TEXT_STYLE.copyWith(
                                  fontWeight: FontUI.WEIGHT_MEDIUM),
                            )
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  })),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * .080,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorUI.GREY.withOpacity(.70),
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Bayar",
                          style: RED_TEXT_STYLE.copyWith(
                              fontSize: 16, fontWeight: FontUI.WEIGHT_BOLD),
                        ),
                        const SizedBox(height: 6),
                        BlocBuilder<CartItemCubit, CartItemState>(
                            builder: (context, state) {
                          if (state is CartItemUpdated) {
                            int totalPrice = state.cartItems.fold(
                                0,
                                (total, item) =>
                                    total +
                                    (item.product.discount == null
                                        ? item.product.price * item.quantity
                                        : item.product.discount! *
                                            item.quantity));

                            return Text(
                              "Rp ${totalPrice.toRupiah()}",
                              style: RED_TEXT_STYLE.copyWith(
                                  fontSize: 16, fontWeight: FontUI.WEIGHT_BOLD),
                            );
                          }
                          return const SizedBox();
                        })
                      ],
                    ),
                    const SizedBox(width: 25),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocBuilder<CartItemCubit, CartItemState>(
                            builder: (context, state) {
                          if (state is CartItemUpdated) {
                            return state.cartItems.isEmpty
                                ? DisableButton(
                                    text: "Pilih Pembayaran",
                                    onPressed: () {
                                      debugPrint("disable");
                                    })
                                : PrimaryButton(
                                    text: "Pilih Pembayaran",
                                    onPressed: () {
                                      debugPrint("go to pembayaran");
                                    });
                          }
                          return const SizedBox();
                        }),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
