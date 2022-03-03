import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ActionCallback<T> = void Function(T? key);

class WiseAlertDialogAction<T> {
  final T key;

  final String label;

  /// 字体加粗(仅在IOS有效).
  final bool isDefaultAction;

  /// 字体颜色变为error
  final bool isDestructiveAction;

  final TextStyle textStyle;

  WiseAlertDialogAction({
    required this.key,
    required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle = const TextStyle(),
  });
}

extension WiseAlertDialogActionEx<T> on WiseAlertDialogAction<T> {
  Widget convertToCupertinoDialogAction({
    required ActionCallback<T> onPressed,
  }) {
    return CupertinoDialogAction(
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      textStyle: textStyle,
      onPressed: () => onPressed(key),
      child: Text(label),
    );
  }

  Widget convertToMaterialDialogAction({
    required ActionCallback<T> onPressed,
    required Color destructiveColor,
    required bool fullyCapitalized,
  }) {
    return TextButton(
      child: Text(
        fullyCapitalized ? label.toUpperCase() : label,
        style: textStyle.copyWith(
          color: isDestructiveAction ? destructiveColor : null,
        ),
      ),
      onPressed: () => onPressed(key),
    );
  }
}

extension WiseAlertDialogActionListEx<T> on List<WiseAlertDialogAction<T>> {
  List<Widget> convertToCupertinoDialogActions({
    required ActionCallback<T> onPressed,
  }) =>
      map((a) => a.convertToCupertinoDialogAction(
            onPressed: onPressed,
          )).toList();

  List<Widget> convertToMaterialDialogActions({
    required ActionCallback<T> onPressed,
    required Color destructiveColor,
    required bool fullyCapitalized,
  }) =>
      map((a) => a.convertToMaterialDialogAction(
            onPressed: onPressed,
            destructiveColor: destructiveColor,
            fullyCapitalized: fullyCapitalized,
          )).toList();
}

enum OkCancelResult {
  ok,
  cancel,
}
