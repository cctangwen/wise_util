import 'package:flutter/material.dart';

import '/res/wise_localizations.dart';
import '/res/wise_style.dart';
import '/util/screen/screen_size_extension.dart';
import '/widget/wise_box.dart';

///页面网络错误状态组件
class WiseMultiStateNoNetwork extends StatelessWidget {
  ///点击网络错误图片事件
  final VoidCallback? retry;

  final bool isFullScreen;

  final String? errorMessage;

  WiseMultiStateNoNetwork(
      {this.retry, this.isFullScreen = true, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    WiseString strings =
        WiseLocalizations.of(context)?.currentLocalization ?? EnWiseString();
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: isFullScreen ? 120.w : 0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (null != retry) retry!();
                },
                child: Image(
                  image: AssetImage(
                    'assets/images/multi_state_no_network.png',
                    package: 'wise_util',
                  ),
                  width: 180.w,
                  height: 100.w,
                ),
              ),
              WiseBox().wBox20,
              Text(
                errorMessage ?? strings.multiStateNoNetwork,
                style: WiseStyle.textStyleLargeLabel(),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
