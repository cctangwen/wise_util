import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///网络图片组件
class WiseImage extends StatelessWidget {
  final double height;

  final double width;

  ///图片资源地址
  final String src;

  final Widget? placeholder;

  final Widget? errorWidget;

  WiseImage({
    required this.height,
    required this.width,
    required this.src,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: src,
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildDefaultImage(),
        placeholder: (context, url) => placeholder ?? _buildDefaultImage(),
      ),
    );
  }

  _buildDefaultImage() => Container(
        width: this.width,
        height: this.height,
        color: Colors.transparent,
      );
}
