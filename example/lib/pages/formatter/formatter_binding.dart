import 'package:get/get.dart';

import 'formatter_controller.dart';

class FormatterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormatterController());
  }
}
