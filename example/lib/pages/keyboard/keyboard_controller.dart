import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wise_util/config/wise_config.dart';
import 'package:wise_util/widget/wise_digital_keyboard.dart';

class KeyboardController extends GetxController {
  bool withOKButton = true;

  final Rx<String> content = Rx<String>("");

  bool isJaJP() {
    return WiseConfig.getRegion() == "ja-JP";
  }

  switchToJaJP(bool value) async {
    if (value) {
      await WiseConfig.setRegion("ja-JP");
      await WiseConfig.setCurrency("JPY");
    } else {
      await WiseConfig.setRegion("zh-CN");
      await WiseConfig.setCurrency("CNY");
    }
    update();
  }

  switchToOKButton(bool value) async {
    withOKButton = value;
    update();
  }

  openKeyboard(BuildContext context) {
    WiseDigitalKeyboardUtil.showKeyBoard(context, withOKButton: withOKButton,
        onChange: (value) {
      content.value = value;
    });
  }

  closeKeyboard() {
    WiseDigitalKeyboardUtil.dismissKeyBoard();
  }
}
