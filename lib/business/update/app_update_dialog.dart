import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:url_launcher/url_launcher.dart';

import '/res/wise_color.dart';
import '/res/wise_localizations.dart';
import '/res/wise_style.dart';
import '/util/screen/screen_size_extension.dart';
import '/widget/wise_box.dart';
import '/widget/wise_button.dart';

///应用更新弹窗
class AppUpdateDialog extends StatelessWidget {
  ///是否强制更新
  final bool isForceUpdate;

  ///版本更新内容描述
  final String description;

  ///android：安装包fileKey
  final String? androidAppId;

  ///ios: iosAppId
  final String? iosAppId;

  final String? h5DownloadUrl;

  AppUpdateDialog({
    this.isForceUpdate = false,
    this.description = "",
    this.androidAppId,
    this.iosAppId,
    this.h5DownloadUrl,
  });

  @override
  Widget build(BuildContext context) {
    WiseString strings =
        WiseLocalizations.of(context)?.currentLocalization ?? EnWiseString();
    return WillPopScope(
      //不允许返回关闭升级对话框
      onWillPop: () async {
        return Future.value(false);
      },
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 280.w,
              height: 130.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/app_update_dialog_header.png',
                    package: 'wise_util',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: 280.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
              decoration: BoxDecoration(
                color: WiseColor.colorSurface(),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    strings.appUpdateDialogTitle,
                    style: WiseStyle.textStyleLargeTitle(),
                  ),
                  WiseBox().hBox12,
                  //更新内容点
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      description,
                      style: WiseStyle.textStyleMediumLabel(),
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  WiseBox().hBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WiseButton.secondaryButton(
                        strings.appUpdateDialogCancel,
                        minWidth: 114.w,
                        onPressed: _cancelUpdate,
                      ),
                      WiseButton.primaryButton(
                        strings.appUpdateDialogUpdate,
                        minWidth: 114.w,
                        onPressed: _confirmUpdate,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///取消（稍后）更新
  void _cancelUpdate() async {
    if (isForceUpdate) {
      ///强制更新，退出应用
      exit(0);
    } else {
      ///非强制更新，关闭弹窗
      Get.back();
    }
  }

  ///确认（现在）更新
  void _confirmUpdate() async {
    if (GetPlatform.isAndroid) {
      _androidUpdate();
      Get.back();
    }
    if (GetPlatform.isIOS) {
      _iosUpdate();
      Get.back();
    }
  }

  /// "1582773616"
  void _iosUpdate() async {
    ///跳转到IOS应用市场
    if (null != iosAppId)
      launch("https://apps.apple.com/cn/app/wiseboss/id$iosAppId");
  }

  void _androidUpdate() async {
    bool canRedirectToGooglePlay = false;
    MethodChannel _channel = const MethodChannel('wise_util');
    canRedirectToGooglePlay =
        await _channel.invokeMethod("isGooglePlayInstalled");
    print("canRedirectToGoogle:$canRedirectToGooglePlay");
    if (null != androidAppId) {
      if (canRedirectToGooglePlay == true) {
        ///跳转到Google应用市场
        launch("https://play.google.com/store/apps/details?id=$androidAppId");
      } else {
        ///跳转到H5官网下载地址
        if (null != h5DownloadUrl) launch(h5DownloadUrl!);
      }
    }
  }
}
