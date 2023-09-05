import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPromoProfile extends StatelessWidget {
  const CardPromoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
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
          ), //BoxShadow
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "Dapatkan Promo Ekslusif",
                      style: BROWN_TEXT_STYLE.copyWith(
                          fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Gabung Komunitas Whatsapp Kopi Kata Rasa sekarang!",
                      style: BROWN_TEXT_STYLE.copyWith(
                          fontWeight: FontUI.WEIGHT_LIGHT),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SvgPicture.asset("assets/icons/coffee_community.svg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .200,
                    height: MediaQuery.of(context).size.height * .100),
              )
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              debugPrint("go to komunitas whatsapp");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: ColorUI.WHITE,
                        borderRadius: BorderRadius.circular(50)),
                    child: Image.asset("assets/icons/icon_whatsapp.png",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * .060,
                        height: MediaQuery.of(context).size.height * .030),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Gabung Komunitas",
                    style: WHITE_TEXT_STYLE.copyWith(
                        fontSize: 16, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
