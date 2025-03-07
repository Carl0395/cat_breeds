import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.backgroundColor = const Color(0xFFA7A7A7),
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: height,
        width: width,
        color: backgroundColor,
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                fadeInDuration: const Duration(seconds: 0),
                fit: fit,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    placeholder ?? renderPlaceholder(context),
                errorWidget: (context, url, error) =>
                    errorWidget ?? renderPlaceholder(context),
              )
            : placeholder ?? renderPlaceholder(context),
      ),
    );
  }

  renderPlaceholder(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    return Container(
      color: scheme.placeholderPhoto,
      child: Icon(
        CupertinoIcons.photo_camera,
        color: scheme.iconPlaceholderPhoto,
        size: 45,
      ),
    );
  }

  renderShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[400]!,
      period: const Duration(seconds: 2),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: const BoxDecoration(color: Colors.black),
      ),
    );
  }
}
