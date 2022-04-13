import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/res/wise_color.dart';
import '/res/wise_localizations.dart';
import '/res/wise_style.dart';
import '/util/screen/screen_size_extension.dart';

///基于Get的加载对话框，loading颜色使用PrimaryColor
class WiseLoading {
  ///显示Loading对话框
  ///closeOnBack 是否允许返回关闭
  ///tips loading下方提示语，默认为loading
  static void show({bool? closeOnBack, String? tips}) {
    Get.dialog(_LoadingDialogWidget(closeOnBack: closeOnBack, tips: tips));
  }

  ///隐藏Loading对话框
  static void dismiss() {
    Navigator.of(Get.context!).pop(true);
  }
}

class _LoadingDialogWidget extends StatelessWidget {
  final bool? closeOnBack;

  final String? tips;

  _LoadingDialogWidget({this.closeOnBack, this.tips});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => closeOnBack ?? false,
        child: _buildDialog(context));
  }

  Widget _buildDialog(BuildContext context) {
    WiseString strings =
        WiseLocalizations
            .of(context)
            ?.currentLocalization ?? EnWiseString();

    ///UnconstrainedBox 破解 Dialog的minWidth: 280.0
    return UnconstrainedBox(
      constrainedAxis: Axis.vertical,
      child: SizedBox(
        width: 120.w,
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.r))),
          insetPadding: EdgeInsets.zero,
          child: Container(
            height: 120.w,
            decoration: BoxDecoration(
              color: WiseColor.colorSurface(),
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: WiseColor.colorPrimary(),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Text(
                    tips ?? strings.loading,
                    style: WiseStyle.textStyleMediumBody(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
