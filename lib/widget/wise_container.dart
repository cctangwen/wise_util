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

  WiseContainer(
      {required this.child,
      this.width,
      this.height,
      this.color,
      this.borderRadius,
      this.padding,
      this.margin,
      this.border,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.all(16.w),
      child: Ink(
        padding: padding ?? EdgeInsets.all(16.w),
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(12.r)),
          border: border,
          color: color ?? WiseColor.colorSurface(),
          boxShadow: boxShadow,
        ),
      ),
    );
  }
}
