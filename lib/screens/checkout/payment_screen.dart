import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:katarasa/data/order/detail_order/detail_order_cubit.dart';
import 'package:katarasa/data/payment/method/method_payment_cubit.dart';
import 'package:katarasa/data/payment/payment_token/payment_cubit.dart';
import 'package:katarasa/data/profile/data_profile/profile_cubit.dart';
import 'package:katarasa/models/payment/methode_pay_request.dart';
import 'package:katarasa/models/payment/payment_snap_before_token.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/general/image.dart';
import 'package:katarasa/widgets/general/loader_indicator.dart';
import 'package:katarasa/widgets/general/make_dismiss.dart';
import 'package:katarasa/widgets/general/toast_comp.dart';
import 'package:katarasa/widgets/order/sheet_payment.dart';
import 'package:katarasa/widgets/shipping/custom_expand_items.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailOrderCubit>().getDetailOrder(context, widget.orderId);
    context.read<MethodPaymentCubit>().getAllMethodPay(context);
    context.read<ProfileCubit>().getDataProfile(context);
  }

  Future<void> navigateToRedirectUrl(String redirectUrl) async {
    if (!await launchUrl(
      Uri.parse(redirectUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $redirectUrl');
    }
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
          "Pembayaran Pesanan",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<DetailOrderCubit, DetailOrderState>(
                  builder: (context, state) {
                if (state is DetailOrderLoading) {
                  return _shimmerContent();
                } else if (state is DetailOrderLoaded) {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.detailOrderLoaded.items.length,
                      itemBuilder: (context, index) {
                        final detail = state.detailOrderLoaded;
                        final item = detail.items[index];
                        final product = item.products[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 15),
                          decoration: const BoxDecoration(color: ColorUI.WHITE),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order Id",
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_LIGHT)),
                                  Text(detail.orderId,
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("No. Invoice",
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_LIGHT)),
                                  Text(item.invoice,
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Divider(
                                thickness: 2,
                                height: 3,
                              ),
                              const SizedBox(height: 10),
                              //column product
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
                                              product.description,
                                              style: BLACK_TEXT_STYLE.copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontUI.WEIGHT_LIGHT),
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${product.qty} item",
                                                  style:
                                                      BLACK_TEXT_STYLE.copyWith(
                                                          fontWeight: FontUI
                                                              .WEIGHT_LIGHT),
                                                ),
                                                product.isDiscount == false
                                                    ? Flexible(
                                                        child: Text(
                                                          product
                                                              .priceCurrencyFormat,
                                                          style: BLACK_TEXT_STYLE
                                                              .copyWith(
                                                                  fontWeight: FontUI
                                                                      .WEIGHT_SEMI_BOLD),
                                                        ),
                                                      )
                                                    : Flexible(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              product
                                                                  .priceDiscountCurrencyFormat,
                                                              style: BLACK_TEXT_STYLE
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontUI
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
                                                        ),
                                                      )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: BLACK_TEXT_STYLE.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                  ),
                                  Text(
                                    detail.totalCurrencyFormat,
                                    style: RED_TEXT_STYLE.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                }
                return const SizedBox();
              }),
              const SizedBox(height: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                decoration: const BoxDecoration(color: ColorUI.WHITE),
                child: BlocBuilder<PaymentCubit, PaymentState>(
                    builder: (context, state) {
                  if (state is PaymentSnapSuccess) {
                    return InkWell(
                        onTap: () {
                          SelectMethod.tokenPayment.isNotEmpty
                              ? sheetPembayaranUpdate(context, widget.orderId)
                              : sheetPembayaran(context, widget.orderId);

                          debugPrint("go to bottom sheet pilih pembayaran");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/icon_payment.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width *
                                        .060,
                                    height: MediaQuery.of(context).size.height *
                                        .025),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.paySnapSuccess.token.isNotEmpty
                                              ? "Ganti pembayaran"
                                              : "Pilih pembayaran",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontWeight: FontUI.WEIGHT_MEDIUM,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    color: ColorUI.GREY, size: 18),
                              ],
                            )
                          ],
                        ));
                  }
                  return const SizedBox();
                  // return InkWell(
                  //     onTap: () {
                  //       sheetPembayaran(context, widget.orderId);
                  //       debugPrint("go to bottom sheet pilih pembayaran");
                  //       setState(() {});
                  //     },
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Image.asset("assets/icons/icon_payment.png",
                  //                 fit: BoxFit.cover,
                  //                 width:
                  //                     MediaQuery.of(context).size.width * .060,
                  //                 height: MediaQuery.of(context).size.height *
                  //                     .025),
                  //             const SizedBox(width: 8),
                  //             Flexible(
                  //               flex: 2,
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text("Pilih pembayaran",
                  //                       style: BLACK_TEXT_STYLE.copyWith(
                  //                           fontWeight: FontUI.WEIGHT_MEDIUM,
                  //                           fontSize: 16)),
                  //                   const SizedBox(height: 3),
                  //                   Text("Anda belum memilih metode pembayaran",
                  //                       style: BLACK_TEXT_STYLE.copyWith(
                  //                           fontWeight: FontUI.WEIGHT_LIGHT,
                  //                           fontSize: 12)),
                  //                 ],
                  //               ),
                  //             ),
                  //             const Spacer(),
                  //             const Icon(Icons.arrow_forward_ios_rounded,
                  //                 color: ColorUI.GREY, size: 18),
                  //           ],
                  //         )
                  //       ],
                  //     ));
                }),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget _shimmerContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .250,
      child: Shimmer.fromColors(
        baseColor: ColorUI.SHIMMER_BASE,
        highlightColor: ColorUI.SHIMMER_HIGHLIGHT,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .250,
          color: Colors.white,
        ),
      ),
    );
  }
}
