import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '/res/wise_color.dart';
import '/res/wise_localizations.dart';
import '/res/wise_style.dart';
import '/util/app_util.dart';
import '/util/permission_util.dart';
import '/util/screen/screen_size_extension.dart';
import '/widget/wise_box.dart';
import '/widget/wise_button.dart';

///应用更新弹窗
class AppUpdateDialog extends StatefulWidget {
  ///是否强制更新
  final bool isForceUpdate;

  ///版本更新内容描述
  final String description;

  ///android：安装包fileKey
  final String? fileKey;

  ///ios: iosAppId
  final String? iosAppId;

  AppUpdateDialog(
      {this.isForceUpdate = false,
      this.description = "",
      this.fileKey,
      this.iosAppId});

  @override
  State<StatefulWidget> createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  bool isDownloadingApk = false;

  double downloadProgress = 0;

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
                      widget.description,
                      style: WiseStyle.textStyleMediumLabel(),
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  WiseBox().hBox20,
                  AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    //显示取消和更新按钮
                    secondChild: Row(
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
                    //下载进度
                    firstChild: Column(
                      children: [
                        Text(
                          strings.downloading,
                          style: WiseStyle.textStyleMediumBody(),
                        ),
                        Container(
                            width: 240.w,
                            height: 14.w,
                            margin: EdgeInsets.only(bottom: 14.w, top: 4.w),
                            child: LinearProgressIndicator(
                              value: downloadProgress,
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xFF019FE8)),
                              backgroundColor:
                                  Color(0xFF019FE8).withOpacity(0.38),
                            )),
                      ],
                    ),
                    crossFadeState: isDownloadingApk
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
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
    if (widget.isForceUpdate) {
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
      if (null != widget.fileKey) _androidUpdate(widget.fileKey!);
    }
    if (GetPlatform.isIOS) {
      if (null != widget.iosAppId) _iosUpdate(widget.iosAppId!);
      Get.back();
    }
  }

  void _androidUpdate(String fileUrl) async {
    WiseString strings =
        WiseLocalizations.of(Get.context!)?.currentLocalization ??
            EnWiseString();

    ///检查存储权限
    bool hasStoragePermission = await PermissionUtil.checkPermission(
        Permission.storage,
        Get.context!,
        strings.requestStoragePermissionToDownload);
    if (!hasStoragePermission) {
      return null;
    }

    /// 创建存储文件
    Directory? storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir!.path;
    String fileName =
        "$storagePath/${DateTime.now().millisecondsSinceEpoch}.apk";
    File file = new File(fileName);
    if (!file.existsSync()) {
      file.createSync();
    }
    try {
      setState(() {
        isDownloadingApk = true;
      });

      /// 发起下载请求
      Response response = await Dio().get(
        fileUrl,
        onReceiveProgress: (num received, num total) {
          setState(() {
            downloadProgress = received / total;
            if (downloadProgress == 1) {
              Get.back();
            }
          });
        },
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      file.writeAsBytesSync(response.data);
      AppInstaller.installApk(fileName);
    } on SocketException {
      ///网络错误提示
      setState(() {
        isDownloadingApk = false;
      });
    } catch (e) {
      setState(() {
        isDownloadingApk = false;
      });
    }
  }

  /// "1582773616"
  void _iosUpdate(String iosAppId) async {
    ///跳转到IOS应用市场
    AppInstaller.goStore(await AppUtil.appPackageName(), iosAppId);
  }
}
