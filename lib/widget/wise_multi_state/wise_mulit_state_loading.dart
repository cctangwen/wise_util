import 'package:flutter/material.dart';

import '/res/wise_color.dart';
import '/util/screen/screen_size_extension.dart';

///页面加载中状态组件
class WiseMultiStateLoading extends StatelessWidget {
  final bool isFullScreen;

  WiseMultiStateLoading({this.isFullScreen = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: isFullScreen ? 120.w : 0.w),
        child: CircularProgressIndicator(
          color: WiseColor.colorPrimary(),
        ),
      ),
    );
  }
}
