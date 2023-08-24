import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

Widget bottomButton(
    String caption, String icon, GestureTapCallback cb, bool isActive) {
  Color color = isActive ? ColorUI.GREY : ColorUI.LIGHT_BROWN;

  TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: isActive ? FontUI.WEIGHT_SEMI_BOLD : FontUI.WEIGHT_LIGHT);

  String imageAsset = 'assets/images/${isActive ? icon : '${icon}_Coklat'}.png';

  return Theme(
    data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child: InkWell(
      onTap: cb,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageAsset, width: 23, height: 23),
            Text(caption, style: textStyle)
          ],
        ),
      ),
    ),
  );
}
