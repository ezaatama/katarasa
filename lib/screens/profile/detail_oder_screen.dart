import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/button/primary_button.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUI.LIGHT_BROWN.withOpacity(.20),
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded,
                  size: 24, color: ColorUI.BLACK),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Detail Pesanan",
            style: BLACK_TEXT_STYLE.copyWith(
                fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.8,
                        decoration: BoxDecoration(
                            color: ColorUI.LIGHT_BROWN.withOpacity(.20)),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/order_confirmed.svg",
                            height: MediaQuery.of(context).size.height * .250,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 50),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorUI.LIGHT_BROWN),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: ColorUI.GREY.withOpacity(.30),
                                offset: const Offset(
                                  4.0,
                                  4.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                            ]),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.my_library_books_outlined,
                                        color: ColorUI.BROWN, size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Detail Pesanan",
                                      style: BLACK_TEXT_STYLE.copyWith(
                                          fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                    )
                                  ],
                                ),
                                Text(
                                  "09 Sept 2023, 11:00",
                                  style: BLACK_TEXT_STYLE.copyWith(
                                      fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                                )
                              ],
                            ),
                            const Divider(thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person_pin_outlined,
                                        color: ColorUI.BROWN, size: 20),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nama Pelanggan",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Reza Putra Pratama",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontWeight:
                                                  FontUI.WEIGHT_SEMI_BOLD),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Divider(thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: ColorUI.WHITE,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: ColorUI.BROWN,
                                              width: 2.0)),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pickup di",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontUI.WEIGHT_LIGHT),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Outlet Kata Rasa - Kota Jakarta Timur",
                                          style: BLACK_TEXT_STYLE.copyWith(
                                              fontWeight:
                                                  FontUI.WEIGHT_SEMI_BOLD),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PrimaryButton(
                                text: "Kembali Ke Beranda",
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3.1,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: ColorUI.WHITE,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: ColorUI.GREY.withOpacity(.30),
                              offset: const Offset(
                                4.0,
                                4.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: Column(
                        children: [
                          Text(
                            "Pesanan Selesai",
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "ID Transaksi #2328049586",
                            style: BLACK_TEXT_STYLE.copyWith(
                                fontWeight: FontUI.WEIGHT_MEDIUM),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
