import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLineShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const CustomLineShimmer({
    super.key,
    required this.height,
    required this.width,
    this.radius = 9.5,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    final baseColor = scheme.baseShimmerColor;
    final highlightColor = scheme.highlightShimmerColor;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(seconds: 3),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
