import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/res/wise_style.dart';

import 'wise_alert_dialog_action.dart';

Future<T?> showWiseAlertDialog<T>({
  required BuildContext context,
  String? title,
  String? message,
  List<WiseAlertDialogAction<T>> actions = const [],
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
  WillPopCallback? onWillPop,
}) {
  void pop(T? key) => Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop(key);
  final titleText = title == null
      ? null
      : Text(title, style: WiseStyle.textStyleLargeTitle());
  final messageText = message == null
      ? null
      : Text(message, style: WiseStyle.textStyleMediumBody());
  return GetPlatform.isIOS
      ? showCupertinoDialog(
          context: context,
          useRootNavigator: useRootNavigator,
          builder: (context) => WillPopScope(
                onWillPop: onWillPop,
                child: CupertinoAlertDialog(
                  title: titleText,
                  content: messageText,
                  actions:
                      actions.convertToCupertinoDialogActions(onPressed: pop),
                ),
              ))
      : showDialog(
          context: context,
          useRootNavigator: useRootNavigator,
          builder: (context) => WillPopScope(
                onWillPop: onWillPop,
                child: AlertDialog(
                  title: titleText,
                  content: messageText,
                  scrollable: true,
                  actionsOverflowDirection: actionsOverflowDirection,
                  actions: actions.convertToMaterialDialogActions(
                      onPressed: pop,
                      destructiveColor: Get.theme.errorColor,
                      fullyCapitalized: fullyCapitalizedForMaterial),
                ),
              ));
}

enum OkCancelAlertDefaultType {
  ok,
  cancel,
}
