import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/widgets/loader.dart';
import 'package:shimmer/shimmer.dart';

class StdImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isCenter;
  final Alignment alignment;

  const StdImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isCenter = true,
    this.alignment = Alignment.center,
  });

  // deprecated
  Widget _loader(double? progress) {
    return SizedBox(
      width: width,
      child: Center(child: StdLoader(value: progress)),
    );
  }

  Widget _shimmerLoader(double? progress) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Shimmer.fromColors(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorUI.SHIMMER_BASE,
              ),
            ),
            baseColor: ColorUI.SHIMMER_BASE,
            highlightColor: ColorUI.SHIMMER_HIGHLIGHT),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      alignment: alignment,
      height: height,
      fit: fit,
      errorWidget: (
        BuildContext context,
        String url,
        err,
      ) {
        return SizedBox(
          width: width,
          child: const Center(
            child: ShimmerLoader(
              child: SizedBox(width: 120, height: 120),
            ),
          ),
        );
        // return const Text('Image failed😢 ');
      },
      progressIndicatorBuilder: (
        BuildContext context,
        String child,
        DownloadProgress loadingProgress,
      ) {
        double? val;
        if (loadingProgress.progress != null) {
          val = loadingProgress.progress;
        }

        if (isCenter) {
          return Center(
            child: _shimmerLoader(val),
          );
        }

        return _shimmerLoader(val);
      },
    );
  }
}
