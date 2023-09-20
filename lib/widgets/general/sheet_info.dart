import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/make_dismiss.dart';

class SheetInfo {
  static void sheetRingkasanPembayaran(BuildContext context) {
    showModalBottomSheet(
        barrierColor: ColorUI.BLACK.withOpacity(0.2),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return makeDismiss(
            context,
            child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.3,
                maxChildSize: 0.6,
                builder: (context, controller) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                        color: ColorUI.WHITE,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        )),
                    child: Stack(
                      children: [
                        ScrollConfiguration(
                          behavior: const MaterialScrollBehavior()
                              .copyWith(overscroll: false),
                          child: ListView(
                            shrinkWrap: true,
                            controller: controller,
                            primary: false,
                            children: [
                              ...notchBottomSheet(),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 70, left: 16, right: 16, bottom: 16),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              BlocBuilder<AllCartCubit, AllCartState>(
                                builder: (context, state) {
                                  if (state is AllCartLoading) {
                                    return const Center(
                                        child: LoaderIndicator());
                                  } else if (state is AllCartLoaded) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount:
                                            state.allCartLoaded.items.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorUI.BLACK
                                                        .withOpacity(.40)),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Produk di beli",
                                                  style:
                                                      BLACK_TEXT_STYLE.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: FontUI
                                                              .WEIGHT_SEMI_BOLD),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      state
                                                          .allCartLoaded
                                                          .items[index]
                                                          .products[index]
                                                          .name,
                                                      style: BLACK_TEXT_STYLE
                                                          .copyWith(
                                                              fontWeight: FontUI
                                                                  .WEIGHT_LIGHT),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        state
                                                            .allCartLoaded
                                                            .items[index]
                                                            .products[index]
                                                            .priceCurrencyFormat,
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                state
                                                            .allCartLoaded
                                                            .items[index]
                                                            .products[index]
                                                            .isDiscount ==
                                                        false
                                                    ? const SizedBox()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                            "Diskon",
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_LIGHT),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "-${state.allCartLoaded.items[index].products[index].priceDiscountCurrencyFormat}",
                                                              style: BLACK_TEXT_STYLE
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontUI
                                                                              .WEIGHT_LIGHT),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                const SizedBox(height: 3),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Quantity",
                                                      style: BLACK_TEXT_STYLE
                                                          .copyWith(
                                                              fontWeight: FontUI
                                                                  .WEIGHT_LIGHT),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "x${state.allCartLoaded.items[index].products[index].qty}",
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                const Divider(
                                                    thickness: 2, height: 2),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "SubTotal = ",
                                                      style: BLACK_TEXT_STYLE
                                                          .copyWith(
                                                              fontWeight: FontUI
                                                                  .WEIGHT_MEDIUM),
                                                    ),
                                                    Text(
                                                      state
                                                          .allCartLoaded
                                                          .items[index]
                                                          .products[index]
                                                          .subTotalCurrencyFormat,
                                                      style: BLACK_TEXT_STYLE
                                                          .copyWith(
                                                              fontWeight: FontUI
                                                                  .WEIGHT_LIGHT),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Total Pembayaran",
                                                      style: BLACK_TEXT_STYLE
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight: FontUI
                                                                  .WEIGHT_SEMI_BOLD),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        state.allCartLoaded
                                                            .totalCartCurrencyFormat,
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
