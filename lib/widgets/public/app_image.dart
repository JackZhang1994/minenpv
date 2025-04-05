import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yunyou_desktop/configs/index.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final double? width, height, borderRadius;
  final Widget? placeholder, errorWidget;

  @override
  Widget build(BuildContext context) {
    final Widget defaultPlaceholder = Container(
      width: width,
      height: height,
      color: Color(0xFFF9F9FB),
    );
    return Container(
      width: width,
      height: height,
      clipBehavior: borderRadius != null ? Clip.hardEdge : Clip.none,
      decoration: borderRadius != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            )
          : null,
      child: CachedNetworkImage(
        imageUrl: AppConfigs.buildImageUrl(url),
        placeholder: (context, url) => placeholder ?? defaultPlaceholder,
        errorWidget: (context, url, error) => errorWidget ?? defaultPlaceholder,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
