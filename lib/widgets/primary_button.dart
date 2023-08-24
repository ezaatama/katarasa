import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.text, required this.onPressed, this.margin})
      : super(key: key);

  final String text;
  final Function() onPressed;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: Text(
            text,
            style: WHITE_TEXT_STYLE.copyWith(
              fontSize: 16,
              fontWeight: FontUI.WEIGHT_MEDIUM,
              letterSpacing: 1.15,
            ),
          )),
    );
  }
}
