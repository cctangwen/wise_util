import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';

class WiseTag extends StatelessWidget {
  final Color? color;

  final String text;

  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  WiseTag({this.color, this.fontSize, this.padding, required this.text});

  @override
  Widget build(BuildContext context) {
    Color _color = this.color ?? WiseColor.colorPrimary();
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        color: _color.withOpacity(0.18),
      ),
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: fontSize ?? 10.sp,
          fontFamily: 'Regular',
          color: _color,
        ),
      ),
    );
  }
}
