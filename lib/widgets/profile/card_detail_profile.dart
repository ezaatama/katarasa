import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class CardDetailProfile extends StatelessWidget {
  const CardDetailProfile(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: ColorUI.WHITE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_SEMI_BOLD),
          ),
          Text(
            value,
            style: BLACK_TEXT_STYLE.copyWith(fontWeight: FontUI.WEIGHT_LIGHT),
          ),
        ],
      ),
    );
  }
}
