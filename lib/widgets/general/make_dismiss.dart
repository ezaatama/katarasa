import 'package:flutter/material.dart';

Widget makeDismiss(BuildContext context, {required Widget child}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.pop(context),
    child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: child),
  );
}
