import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/checkout/data_checkout/data_checkout_cubit.dart';
import 'package:katarasa/data/checkout/data_shipping/data_shipping_cubit.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/make_dismiss.dart';
import 'package:katarasa/widgets/shipping/data_shipping.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DataCheckoutCubit>().getAllCheckout(context);
    context.read<DataShippingCubit>().getDataShipping(context);
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
          "Data Checkout",
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
                child: BlocBuilder<DataCheckoutCubit, DataCheckoutState>(
              builder: (context, state) {
                if (state is DataCheckoutLoading) {
                  return const Center(child: LoaderIndicator());
                } else if (state is DataCheckoutLoaded) {
                  final address = state.checkoutLoaded.address;
                  final cart = state.checkoutLoaded.cart;
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        decoration: const BoxDecoration(color: ColorUI.WHITE),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_sharp,
                              color: ColorUI.BROWN,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.checkoutLoaded.address.label,
                                    style: RED_TEXT_STYLE.copyWith(
                                        fontWeight: FontUI.WEIGHT_MEDIUM),
                                  ),
                                  Text(
                                    "${address.receiverName} (${address.phoneNumber})",
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontSize: 16,
                                        color: ColorUI.BLACK.withOpacity(.50),
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    address.address,
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        color: ColorUI.BLACK.withOpacity(.50),
                                        fontWeight: FontUI.WEIGHT_LIGHT),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        decoration: const BoxDecoration(color: ColorUI.WHITE),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final product = cart[index].products[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Image.network(
                                          cart[index].store.image),
                                    ),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        cart[index].store.name,
                                        style: BLACK_TEXT_STYLE.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontUI.WEIGHT_MEDIUM),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StdImage(
                                            imageUrl: product.image,
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .200,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .100),
                                        const SizedBox(width: 10),
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontUI.WEIGHT_SEMI_BOLD),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              "${product.qty} item",
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  fontWeight:
                                                      FontUI.WEIGHT_LIGHT),
                                            ),
                                            const SizedBox(height: 10),
                                            product.isDiscount == false
                                                ? Text(
                                                    product.priceCurrencyFormat,
                                                    style: BLACK_TEXT_STYLE
                                                        .copyWith(
                                                            fontWeight: FontUI
                                                                .WEIGHT_SEMI_BOLD),
                                                  )
                                                : Column(
                                                    children: [
                                                      Text(
                                                        product
                                                            .priceDiscountCurrencyFormat,
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontWeight: FontUI
                                                                    .WEIGHT_SEMI_BOLD),
                                                      ),
                                                      Text(
                                                        product
                                                            .priceCurrencyFormat,
                                                        style: BLACK_TEXT_STYLE.copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontWeight: FontUI
                                                                .WEIGHT_LIGHT),
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    cart[index].shippingSelected.code.isEmpty
                                        ? Text(
                                            "*Anda belum memilih pengiriman",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_LIGHT),
                                          )
                                        : Text("sudah pilih shipping"),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      //voucher discount
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        decoration: const BoxDecoration(color: ColorUI.WHITE),
                        child: InkWell(
                          onTap: () {
                            debugPrint("go to bottom sheet voucher discount");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.discount_rounded,
                                      color: Colors.red, size: 20),
                                  const SizedBox(width: 8),
                                  Text("Voucher discount",
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_MEDIUM,
                                          fontSize: 16)),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      color: ColorUI.GREY, size: 18),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      //select shipping
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        decoration: const BoxDecoration(color: ColorUI.WHITE),
                        child: InkWell(
                          onTap: () {
                            _sheetShipping();
                            debugPrint("go to bottom sheet pilih pengiriman");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/icons/free-delivery.png",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          .060,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .025),
                                  const SizedBox(width: 8),
                                  Text("Pilih pengiriman",
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_MEDIUM,
                                          fontSize: 16)),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      color: ColorUI.GREY, size: 18),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
                return const SizedBox();
              },
            )),
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
                        text: "Pesan",
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

  void _sheetShipping() {
    showModalBottomSheet(
        barrierColor: ColorUI.BLACK.withOpacity(0.2),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return makeDismiss(context,
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
                                ...notchBottomSheet("Pilih Pengiriman"),
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
                                BlocBuilder<DataShippingCubit,
                                        DataShippingState>(
                                    builder: (context, state) {
                                  if (state is DataShippingLoading) {
                                    return const Center(
                                        child: LoaderIndicator());
                                  } else if (state is DataShippingLoaded) {
                                    return Column(
                                      children: state.shippingLoaded.items
                                          .map((e) => Text(e.code))
                                          .toList(),
                                    );
                                  }
                                  return const SizedBox();
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
        });
  }
}
