import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';

///头像组件
class WiseAvatar extends StatelessWidget {
  ///图片大小
  final double? size;

  ///网络头像资源地址
  final String? src;

  ///文本头像
  final String? alt;

  ///Icon头像
  final Icon? icon;

  ///头像背景色
  final Color? backgroundColor;

  ///文本头像文本样式
  final TextStyle? altStyle;

  ///默认图片大小尺寸
  final double defaultSize = 40.w;

  WiseAvatar({
    this.size,
    this.src,
    this.alt,
    this.altStyle,
    this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (null != src) {
      return ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          width: size ?? defaultSize,
          height: size ?? defaultSize,
          imageUrl: src!,
          errorWidget: (context, url, error) => _buildDefaultAvatarImage(),
          placeholder: (context, url) => _buildDefaultAvatarImage(),
        ),
      );
    }
    if (null != alt) {
      return ClipOval(
        child: Container(
          width: size ?? defaultSize,
          height: size ?? defaultSize,
          alignment: Alignment.center,
          color: backgroundColor ?? WiseColor.colorPrimary(),
          child: Text(
            alt!,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: altStyle ??
                TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
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
    return _buildDefaultAvatarImage();
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
