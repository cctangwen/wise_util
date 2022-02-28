import 'package:get/get.dart';

import 'keyboard_controller.dart';

class KeyboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KeyboardController());
  }
}
