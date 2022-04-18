import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';

class WiseDivider extends StatelessWidget {
  final double? width;

  final double? height;

  final double? startPadding;

  final double? endPadding;

  final Color? color;

  WiseDivider(
      {this.width,
      this.height,
      this.startPadding,
      this.endPadding,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: startPadding ?? 0.w, right: endPadding ?? 0.w),
      width: width ?? double.infinity,
      height: height ?? 1.w,
      color: color ?? WiseColor.colorSurfaceVariant(),
    );
  }
}
