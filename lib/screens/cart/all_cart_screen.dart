import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/cart/all_cart/all_cart_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/cart/single_cart.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/sheet_info.dart';

class AllCartScreen extends StatefulWidget {
  const AllCartScreen({super.key});

  @override
  State<AllCartScreen> createState() => _AllCartScreenState();
}

class _AllCartScreenState extends State<AllCartScreen>
    with AutomaticKeepAliveClientMixin<AllCartScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<AllCartCubit>().getAllCart(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                _bodyContent(),
                Positioned(
                  height: 24.0,
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: connected
                      ? const SizedBox()
                      : Container(
                          color: const Color(0xFFEE4400),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Periksa Kembali Jaringan Anda",
                                    style: WHITE_TEXT_STYLE.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
          child: _bodyContent()),
    );
  }

  Widget _bodyContent() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                size: 24, color: ColorUI.BLACK),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Keranjang Anda",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 15, right: 16),
                  child: BlocBuilder<AllCartCubit, AllCartState>(
                    builder: (context, state) {
                      if (state is AllCartLoading) {
                        return const LoaderIndicator();
                      } else if (state is AllCartLoaded) {
                        final allCartProduct = state.allCartLoaded.items;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allCartProduct.length,
                          itemBuilder: (context, index) {
                            return SingleCart(
                              products: allCartProduct[index].products[index],
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  )),
            ),
          ),
          BlocBuilder<AllCartCubit, AllCartState>(
            builder: (context, state) {
              if (state is AllCartLoading) {
                return const Center(child: LoaderIndicator());
              } else if (state is AllCartLoaded) {
                final isSelected = state.allCartLoaded.totalProductSelected;
                final namaProduk = state.allCartLoaded.items
                    .map((e) => e.products.map((e) => e.name))
                    .toString();
                final hargaPerItem = state.allCartLoaded.items
                    .map((e) => e.products.map((e) => e.priceCurrencyFormat))
                    .toString();
                final qty = state.allCartLoaded.items
                    .map((e) => e.products.map((e) => e.qty))
                    .toString();

                return isSelected == 0
                    ? const SizedBox()
                    : Positioned(
                        bottom: 80,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: ColorUI.GREY.withOpacity(.40),
                                offset: const Offset(
                                  3.0,
                                  3.0,
                                ),
                                blurRadius: 12.0,
                                spreadRadius: 1.0,
                              ), //BoxShadow
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ringkasan Pemesanan",
                                style: BLACK_TEXT_STYLE.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Quantity",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_LIGHT),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${state.allCartLoaded.totalCart.toString()} item",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Produk di keranjang",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight: FontUI.WEIGHT_LIGHT),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${state.allCartLoaded.totalData.toString()} item",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Pembayaran",
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontWeight:
                                                FontUI.WEIGHT_SEMI_BOLD),
                                      ),
                                      Flexible(
                                        child: Text(
                                          state.allCartLoaded
                                              .totalCartCurrencyFormat,
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 2),
                                  InkWell(
                                    onTap: () {
                                      debugPrint(
                                          "pop up modal detail pembayaran");
                                      SheetInfo.sheetRingkasanPembayaran(
                                          context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lihat Detail",
                                          style: BROWN_TEXT_STYLE.copyWith(
                                              fontWeight: FontUI.WEIGHT_BOLD),
                                        ),
                                        const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 22,
                                            color: ColorUI.BROWN)
                                      ],
                                    ),
                                  ),
                                  const Divider(thickness: 2),
                                ],
                              )
                            ],
                          ),
                        ));
              }
              return const SizedBox();
            },
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryButton(
                        text: "Checkout",
                        onPressed: () {
                          debugPrint("go to pembayaran");
                        })
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
