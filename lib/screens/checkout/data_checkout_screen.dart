import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/checkout/data_checkout/data_checkout_cubit.dart';
import 'package:katarasa/data/checkout/data_shipping/data_shipping_cubit.dart';
import 'package:katarasa/models/checkout/checkout_request.dart';
import 'package:katarasa/models/checkout/select_shipping_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/disable_button.dart';
import 'package:katarasa/widgets/button/loading_button.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/make_dismiss.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:katarasa/widgets/shipping/custom_expand_items.dart';
import 'package:katarasa/widgets/shipping/custom_shipping_time.dart';
import 'package:shimmer/shimmer.dart';

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
                  return _shimmerContent();
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
                                    cart[index].shippingSelected.code.isEmpty &&
                                            SelectShipping.shipDesc.isEmpty &&
                                            SelectShipping.shipEdText.isEmpty
                                        ? Text(
                                            "*Anda belum memilih pengiriman",
                                            style: BLACK_TEXT_STYLE.copyWith(
                                                fontWeight:
                                                    FontUI.WEIGHT_LIGHT),
                                          )
                                        : cart[index]
                                                    .shippingSelected
                                                    .code
                                                    .isNotEmpty &&
                                                SelectShipping
                                                    .shipDesc.isEmpty &&
                                                SelectShipping
                                                    .shipEdText.isEmpty
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorUI.GREY
                                                          .withOpacity(.20),
                                                      offset: const Offset(
                                                        0.0,
                                                        2.0,
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            cart[index]
                                                                .shippingSelected
                                                                .description,
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                        Flexible(
                                                          child: Text(
                                                              state
                                                                  .checkoutLoaded
                                                                  .shippingCostCurrencyFormat,
                                                              style: BLACK_TEXT_STYLE
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontUI
                                                                              .WEIGHT_SEMI_BOLD)),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                        "Estimasi pengiriman ${cart[index].shippingSelected.etdText}",
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 12,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        "Berat ${cart[index].totalWeight}",
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 12,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT)),
                                                    const SizedBox(height: 7),
                                                    const Divider(
                                                        thickness: 2,
                                                        height: 4),
                                                    const SizedBox(height: 7),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Total Pembayaran",
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_LIGHT)),
                                                        Text(
                                                            state.checkoutLoaded
                                                                .totalCurrencyFormat,
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorUI.GREY
                                                          .withOpacity(.20),
                                                      offset: const Offset(
                                                        0.0,
                                                        2.0,
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            SelectShipping
                                                                .shipDesc,
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                        Text(
                                                            SelectShipping
                                                                .shipCurrency,
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        "Estimasi pengiriman ${SelectShipping.shipEdText}",
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 12,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        "Berat ${cart[index].totalWeight}",
                                                        style: BLACK_TEXT_STYLE
                                                            .copyWith(
                                                                fontSize: 12,
                                                                fontWeight: FontUI
                                                                    .WEIGHT_LIGHT)),
                                                    const SizedBox(height: 7),
                                                    const Divider(
                                                        thickness: 2,
                                                        height: 4),
                                                    const SizedBox(height: 7),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Total Pembayaran",
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_LIGHT)),
                                                        Text(
                                                            state.checkoutLoaded
                                                                .totalCurrencyFormat,
                                                            style: BLACK_TEXT_STYLE
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                            _sheetVoucher();
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
                    BlocConsumer<DataCheckoutCubit, DataCheckoutState>(
                      listener: (context, state) {
                        if (state is PostCheckoutSuccess) {
                          showToast(
                              text: state.coSuccess,
                              state: ToastStates.SUCCESS);

                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        } else if (state is PostCheckoutError) {
                          showToast(
                              text: state.coError, state: ToastStates.ERROR);
                        }
                      },
                      builder: (context, state) {
                        if (state is DataCheckoutLoaded) {
                          final resCo = context.read<DataCheckoutCubit>();

                          final cart = state.checkoutLoaded.cart;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              return resCo.isCheckout
                                  ? LoadingButton(onPressed: () {
                                      debugPrint('response loading');
                                    })
                                  : cart[index].shippingSelected.code.isEmpty &&
                                          SelectShipping.shipDesc.isEmpty &&
                                          SelectShipping.shipEdText.isEmpty
                                      ? DisableButton(
                                          text: "Pembayaran", onPressed: () {})
                                      : cart[index]
                                                  .shippingSelected
                                                  .code
                                                  .isEmpty ||
                                              cart[index]
                                                      .shippingSelected
                                                      .code
                                                      .isNotEmpty &&
                                                  SelectShipping
                                                      .shipDesc.isNotEmpty &&
                                                  SelectShipping
                                                      .shipEdText.isNotEmpty
                                          ? PrimaryButton(
                                              text: "Pembayaran",
                                              onPressed: () {
                                                AddToCheckoutRequest payload =
                                                    AddToCheckoutRequest(
                                                        note1: '',
                                                        note2: '',
                                                        koin: false);
                                                context
                                                    .read<DataCheckoutCubit>()
                                                    .postCheckout(
                                                        context, payload);
                                                debugPrint("go to pembayaran");
                                              })
                                          : const SizedBox();
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  void _sheetVoucher() {
    showModalBottomSheet(
        barrierColor: ColorUI.BLACK.withOpacity(0.2),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStater) {
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
                                  ...notchBottomSheet("Voucher Discount"),
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
                                  BlocBuilder<DataCheckoutCubit,
                                          DataCheckoutState>(
                                      builder: (context, state) {
                                    if (state is DataCheckoutLoading) {
                                      return const Center(
                                          child: LoaderIndicator());
                                    } else if (state is DataCheckoutLoaded) {
                                      final voucher =
                                          state.checkoutLoaded.voucherJaja;
                                      return Column(
                                        children: voucher.map((e) {
                                          return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorUI.GREY
                                                        .withOpacity(.20),
                                                    offset: const Offset(
                                                      0.0,
                                                      2.0,
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
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                                text: TextSpan(
                                                                    text:
                                                                        "Berlaku mulai dari ",
                                                                    style: BLACK_TEXT_STYLE.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontUI.WEIGHT_LIGHT),
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "${e.startDate}\n",
                                                                    style: BLACK_TEXT_STYLE.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontUI.WEIGHT_BOLD),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        "hingga ",
                                                                    style: BLACK_TEXT_STYLE.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontUI.WEIGHT_LIGHT),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        "${e.endDate}\n",
                                                                    style: BLACK_TEXT_STYLE.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontUI.WEIGHT_BOLD),
                                                                  )
                                                                ])),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(e.name,
                                                                style: BLACK_TEXT_STYLE.copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                            const SizedBox(
                                                                height: 3),
                                                            Text(e.discountText,
                                                                style: BLACK_TEXT_STYLE.copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_SEMI_BOLD)),
                                                            const SizedBox(
                                                                height: 5),
                                                            Text(
                                                                "Kuota ${e.quota}",
                                                                style: BLACK_TEXT_STYLE.copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontUI
                                                                            .WEIGHT_LIGHT)),
                                                          ],
                                                        ),
                                                      ),
                                                      //Tinggal di uncomment aja imageUrl nya, ini pake hardoce karna image dari API 404
                                                      StdImage(
                                                          // imageUrl: e.image,
                                                          imageUrl:
                                                              'https://cdn.urbandigital.id/wp-content/uploads/2018/11/b_artikel_lazada_priceor17_7nov17.jpg',
                                                          fit: BoxFit.contain,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .250,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .080)
                                                    ],
                                                  )
                                                ],
                                              ));
                                        }).toList(),
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
        });
  }

  void _sheetShipping() {
    showModalBottomSheet(
        barrierColor: ColorUI.BLACK.withOpacity(0.2),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStater) {
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
                                  ...notchBottomSheet("Waktu Pengiriman"),
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
                                      final store = state.shippingLoaded.store;
                                      return Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 8.0,
                                              runSpacing: 4.0,
                                              direction: Axis.horizontal,
                                              children: state
                                                  .shippingLoaded.sendTime
                                                  .map((e) {
                                                return CustomTimeShipping(
                                                    value: e.value,
                                                    groupValue: SelectShipping
                                                        .selectTime,
                                                    time: e,
                                                    onChanged: (val) {
                                                      setStater(() {
                                                        SelectShipping
                                                            .selectTime = val;
                                                        debugPrint(
                                                            "ini select Time => ${SelectShipping.selectTime}");
                                                      });
                                                    });
                                              }).toList(),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Center(
                                            child: Text(
                                              "Pilih Pengiriman",
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontUI.WEIGHT_SEMI_BOLD),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Column(
                                              children: state
                                                  .shippingLoaded.items
                                                  .map((e) {
                                            final index = state
                                                .shippingLoaded.items
                                                .indexOf(e);
                                            return StatefulBuilder(
                                                builder: (context, setStaters) {
                                              return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors
                                                              .transparent),
                                                  child: CustomExpandableItem(
                                                      header: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 8),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                                child: Text(
                                                              e.name,
                                                              style: BLACK_TEXT_STYLE
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontUI
                                                                              .WEIGHT_SEMI_BOLD),
                                                            )),
                                                            StdImage(
                                                                imageUrl:
                                                                    e.icon,
                                                                fit: BoxFit
                                                                    .contain,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .150,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .040)
                                                          ],
                                                        ),
                                                      ),
                                                      expandedChild: Column(
                                                        children:
                                                            e.type.map((type) {
                                                          final indexed = e.type
                                                              .indexOf(type);
                                                          return InkWell(
                                                            onTap: () {
                                                              setStater(() {
                                                                if (SelectShipping
                                                                        .selectType ==
                                                                    type.code) {
                                                                  SelectShipping
                                                                          .selectType =
                                                                      "no select";
                                                                } else {
                                                                  SelectShipping
                                                                          .selectType =
                                                                      type.code;
                                                                  SelectShipping
                                                                          .shipEdText =
                                                                      type.etdText;
                                                                  SelectShipping
                                                                          .shipCurrency =
                                                                      type.priceCurrencyFormat;

                                                                  SelectShipping
                                                                      payload =
                                                                      SelectShipping(
                                                                          storeId: store
                                                                              .id,
                                                                          //address id set default hardcode because in API is null and don't know address id is select from where
                                                                          addressId:
                                                                              "1583",
                                                                          shippingCode: SelectShipping
                                                                              .selectItem,
                                                                          shippingTipe: SelectShipping
                                                                              .selectType,
                                                                          sendTime:
                                                                              SelectShipping.selectTime);
                                                                  context
                                                                      .read<
                                                                          DataShippingCubit>()
                                                                      .selectShipping(
                                                                          context,
                                                                          payload);
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                                debugPrint(
                                                                    "ini selected type => ${SelectShipping.selectedType}, ini index type $indexed dan ini penampung option ${SelectShipping.selectType}");
                                                              });
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10),
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 25,
                                                                      right:
                                                                          15),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8),
                                                                decoration: SelectShipping
                                                                            .selectType ==
                                                                        type
                                                                            .code
                                                                    ? BoxDecoration(
                                                                        color: ColorUI
                                                                            .BROWN
                                                                            .withOpacity(
                                                                                .20),
                                                                        border: Border.all(
                                                                            color: ColorUI
                                                                                .BROWN,
                                                                            width:
                                                                                1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10))
                                                                    : null,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          type.name,
                                                                          style:
                                                                              BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_MEDIUM),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                3),
                                                                        Text(
                                                                          type.etdText,
                                                                          style:
                                                                              BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_LIGHT),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      type.priceCurrencyFormat,
                                                                      style: BLACK_TEXT_STYLE.copyWith(
                                                                          fontWeight:
                                                                              FontUI.WEIGHT_SEMI_BOLD),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                      isExpanded: SelectShipping
                                                              .selectItem ==
                                                          e.code,
                                                      onTap: () {
                                                        setStater(() {
                                                          // if (selectedIndex ==
                                                          //     index) {
                                                          //   // Clicking an already open section should close it
                                                          //   selectedIndex = -1;
                                                          // } else {
                                                          //   selectedIndex =
                                                          //       index;
                                                          // }
                                                          if (SelectShipping
                                                                  .selectItem ==
                                                              e.code) {
                                                            SelectShipping
                                                                    .selectItem =
                                                                "no select";
                                                          } else {
                                                            SelectShipping
                                                                    .selectItem =
                                                                e.code;
                                                            SelectShipping
                                                                    .shipDesc =
                                                                e.name;
                                                          }
                                                          debugPrint(
                                                              "ini selected type => ${SelectShipping.selectedType}, ini index type $index dan ini penampung option ${SelectShipping.selectItem}");
                                                        });
                                                      }));
                                            });
                                          }).toList()),
                                        ],
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
        }).then((value) {
      setState(() {
        SelectShipping.shipDesc;
        SelectShipping.shipEdText;
        SelectShipping.selectItem;
        SelectShipping.selectType;
        SelectShipping.selectTime;
        SelectShipping.shipCurrency;
      });
    });
  }

  Widget _shimmerContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
        baseColor: ColorUI.SHIMMER_BASE,
        highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
