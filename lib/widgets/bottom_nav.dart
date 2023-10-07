import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

Widget bottomButton(String caption, String icon, GestureTapCallback cb,
    bool isActive, BuildContext context) {
  Color color = isActive ? ColorUI.WHITE : const Color(0xFFEDFFF2);

  TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: isActive ? FontUI.WEIGHT_SEMI_BOLD : FontUI.WEIGHT_LIGHT);

  String imageAsset = 'assets/icons/${isActive ? icon : '${icon}_green'}.png';

  return Theme(
    data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child: InkWell(
      onTap: cb,
      child: SizedBox(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isActive
                ? Container(
                    width: MediaQuery.of(context).size.width * .100,
                    height: 3,
                    decoration: const BoxDecoration(color: ColorUI.WHITE),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * .100,
                    height: 3,
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
            const SizedBox(height: 15),
            Image.asset(imageAsset, width: 23, height: 23),
            Text(caption, style: textStyle)
          ],
        ),
      ),
    ),
  );
}
