import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';

class WiseContainer extends StatelessWidget {
  ///宽度
  final double? width;

  ///高度
  final double? height;

  final Widget child;

  ///背景颜色，默认WiseColor.colorSurface
  final Color? color;

  final BorderRadiusGeometry? borderRadius;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final BoxBorder? border;

  final List<BoxShadow>? boxShadow;

  final GestureTapCallback? onTap;

  final DecorationImage? image;

  WiseContainer({
    required this.child,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(16.w),
      width: width,
      height: height,
      child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: padding ?? EdgeInsets.all(16.w),
            child: child,
          )),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(12.r)),
        border: border,
        color: color ?? WiseColor.colorSurface(),
        boxShadow: boxShadow,
        image: image,
      ),
    );
  }
}
