import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderIndicator extends StatelessWidget {
  const LoaderIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: ColorUI.BROWN,
        size: 40,
      ),
    );
  }
}
