import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';

///头像组件
class WiseAvatar extends StatelessWidget {
  ///图片大小
  final double? size;

  ///网络头像资源地址
  final String? src;

  ///文本头像
  final String? alt;

  ///本地图片地址
  final String? asset;

  ///Icon头像
  final Icon? icon;

  ///头像背景色
  final Color? backgroundColor;

  ///图片颜色
  final Color? color;

  ///文本头像文本样式
  final TextStyle? altStyle;

  ///默认图片大小尺寸
  final double defaultSize = 40.w;

  final Widget? defaultImage;

  final bool nullImage;

  WiseAvatar({
    this.size,
    this.src,
    this.alt,
    this.altStyle,
    this.icon,
    this.asset,
    this.backgroundColor,
    this.color,
    this.defaultImage,
    this.nullImage = false,
  });

  @override
  Widget build(BuildContext context) {
    if (nullImage) {
      return _buildDefaultAvatarImage();
    }
    if (null != src) {
      return ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          width: size ?? defaultSize,
          height: size ?? defaultSize,
          imageUrl: src!,
          errorWidget: (context, url, error) =>
              defaultImage ?? _buildDefaultAvatarImage(),
          placeholder: (context, url) =>
              defaultImage ?? _buildDefaultAvatarImage(),
        ),
      );
    }
    if (null != alt) {
      return Container(
        width: size ?? defaultSize,
        height: size ?? defaultSize,
        padding: EdgeInsets.all(4.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? WiseColor.colorPrimary().withOpacity(0.18),
          shape: BoxShape.circle,
        ),
        child: Text(
          alt!,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: altStyle ??
              WiseStyle.textStyleLargeBody().copyWith(
                color: color ?? WiseColor.colorPrimary(),
              ),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (null != icon) {
      return ClipOval(
        child: Container(
          width: size ?? defaultSize,
          height: size ?? defaultSize,
          alignment: Alignment.center,
          color: backgroundColor ?? WiseColor.colorPrimary(),
          child: icon,
        ),
      );
    }
    if (null != asset) {
      return Container(
        width: size ?? defaultSize,
        height: size ?? defaultSize,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: backgroundColor ?? WiseColor.colorPrimary().withOpacity(0.18),
          shape: BoxShape.circle,
        ),
        child: Image(
          fit: BoxFit.contain,
          color: color ?? WiseColor.colorPrimary(),
          image: AssetImage(asset!),
        ),
      );
    }
    return defaultImage ?? _buildDefaultAvatarImage();
  }

  ///默认头像
  _buildDefaultAvatarImage() => ClipOval(
        child: Image(
          fit: BoxFit.fill,
          width: size ?? defaultSize,
          height: size ?? defaultSize,
          image: AssetImage(
            "assets/images/avatar_default.png",
            package: "wise_util",
          ),
        ),
      );
}
