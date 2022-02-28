import 'package:get/get.dart';

import 'multi_state_controller.dart';

class MultiStateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MultiStateController());
  }
}
