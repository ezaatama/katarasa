import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconSuffixButton extends StatelessWidget {
  const IconSuffixButton(
      {Key? key, required this.isObscure, required this.onPressed})
      : super(key: key);

  final bool isObscure;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String eyeImg = isObscure ? "icon_eye_open.png" : "icon_eye_closed.png";

    Widget eyeIcon = Image.asset(
      "assets/icons/$eyeImg",
      width: 20,
      height: 20,
    );

    if (Platform.isAndroid) {
      return CupertinoButton(
        onPressed: onPressed,
        child: eyeIcon,
      );
    } else {
      return IconButton(
        icon: eyeIcon,
        onPressed: onPressed,
      );
    }
  }
}
