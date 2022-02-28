import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/res/wise_color.dart';

///页面加载中状态组件
class WiseMultiStateLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Get.height / 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: WiseColor.colorPrimary(),
          ),
        ],
      ),
    );
  }
}
