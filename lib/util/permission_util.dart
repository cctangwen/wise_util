import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wise_util/widget/wise_alert_dialog/show_wise_ok_alert_dialog.dart';
import 'package:wise_util/widget/wise_alert_dialog/wise_alert_dialog.dart';

import '/res/wise_localizations.dart';
import '/util/sp_util.dart';

class PermissionUtil {
  static Future<bool> checkPermission(
      Permission permission, BuildContext context, String errorHint) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      //权限通过
      return true;
    } else if (status.isDenied) {
      //权限被拒绝
      return _requestPermission(permission, context, errorHint);
    } else if (status.isPermanentlyDenied) {
      //权限永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
      _showOpenAppSetting(context, errorHint);
    } else if (status.isRestricted || status.isLimited) {
      //活动限制（例如，设置了家长///控件，仅在iOS以上受支持
      _showOpenAppSetting(context, errorHint);
    } else {
      //第一次申请
      return _requestPermission(permission, context, errorHint);
    }
    return false;
  }

  static Future<bool> _requestPermission(
      Permission permission, BuildContext context, String errorHint) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    // 返回权限申请的状态 status
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      ///Android API 30+ 不再返回 permanentlyDenied
      _showOpenAppSetting(context, errorHint);
    } else if (status.isDenied) {
      bool shouldShow = await permission.shouldShowRequestRationale;
      bool localShow = SpUtil.getBool("PermissionStatus${permission.value}",
          defValue: false)!;
      if (localShow != true) {
        await SpUtil.putBool("PermissionStatus${permission.value}", shouldShow);
      } else if (shouldShow == false && localShow == true) {
        _showOpenAppSetting(context, errorHint);
      }
    }
    return false;
  }

  static _showOpenAppSetting(BuildContext context, String errorHint) async {
    WiseString strings =
        WiseLocalizations.of(context)?.currentLocalization ?? EnWiseString();
    var okCancelResult = await showWiseOkAlertDialog(
        context: context,
        title: strings.requestPermissionTitle,
        okLabel: strings.requestPermissionButton,
        message: errorHint);
    if (okCancelResult == OkCancelResult.ok) {
      openAppSettings();
    }
  }
}
