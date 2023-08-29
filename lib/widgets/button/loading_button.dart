import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key, required this.onPressed, this.margin})
      : super(key: key);

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
            backgroundColor: ColorUI.BROWN.withOpacity(.5),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorUI.LIGHT_BROWN.withOpacity(.20)),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * .06,
              height: MediaQuery.of(context).size.height * .03,
              child: const CircularProgressIndicator(
                color: ColorUI.WHITE,
                strokeWidth: 3,
              ))),
    );
  }
}
