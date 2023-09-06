import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class CardAllOrder extends StatelessWidget {
  const CardAllOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Go to order detail");
        Navigator.pushNamed(context, '/order-detail');
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
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
          ), //BoxShadow
        ]),
        child: Column(
          children: [
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
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: ColorUI.BROWN, width: 2.0)),
                    ),
                    const SizedBox(width: 10),
                    Text("Outlet Kata Rasa",
                        style: BROWN_TEXT_STYLE.copyWith(
                            fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
                  ],
                ),
                Text(
                  "06 Sept 2023, 11:00",
                  style: LIGHT_BROWN_TEXT_STYLE.copyWith(
                      fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(color: Colors.transparent)),
                const SizedBox(width: 10),
                Text("Alat Mesin Kopi x 1",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_MEDIUM)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(color: Colors.transparent)),
                const SizedBox(width: 10),
                Text("Total 1 Product \u2022 Rp 150.000",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_LIGHT)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(color: Colors.transparent)),
                const SizedBox(width: 10),
                Text("Pesanan Selesai",
                    style: BLACK_TEXT_STYLE.copyWith(
                        fontWeight: FontUI.WEIGHT_MEDIUM)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
