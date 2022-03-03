import 'package:flutter/material.dart';

import 'show_wise_alert_dialog.dart';
import 'wise_alert_dialog_action.dart';

Future<OkCancelResult> showWiseOkAlertDialog({
  required BuildContext context,
  String? title,
  String? message,
  String? okLabel,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
  bool fullyCapitalizedForMaterial = true,
  WillPopCallback? onWillPop,
}) async {
  final result = await showWiseAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    fullyCapitalizedForMaterial: fullyCapitalizedForMaterial,
    onWillPop: onWillPop,
    actions: [
      WiseAlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
      )
    ],
  );
  return result ?? OkCancelResult.cancel;
}
