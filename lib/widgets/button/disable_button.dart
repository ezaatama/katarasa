import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class DisableButton extends StatelessWidget {
  const DisableButton(
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
            backgroundColor: ColorUI.BACKGROUND_COLOR,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: Text(
            text,
            style: BLACK_TEXT_STYLE.copyWith(
              color: ColorUI.BLACK.withOpacity(.50),
              fontSize: 16,
              fontWeight: FontUI.WEIGHT_MEDIUM,
              letterSpacing: 1.15,
            ),
          )),
    );
  }
}
