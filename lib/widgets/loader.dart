import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:shimmer/shimmer.dart';

class StdLoader extends StatelessWidget {
  final Color? color;
  final double? value;

  const StdLoader({
    Key? key,
    this.color,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color loadingColor = color != null ? color! : Colors.red;

    return CircularProgressIndicator(
      color: loadingColor,
      value: value,
    );
  }
}

class ShimmerLoader extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Widget child;

  const ShimmerLoader({
    Key? key,
    this.baseColor = ColorUI.SHIMMER_BASE,
    this.highlightColor = ColorUI.SHIMMER_HIGHLIGHT,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }
}
