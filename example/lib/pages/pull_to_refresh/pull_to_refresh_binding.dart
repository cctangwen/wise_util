import 'package:get/get.dart';

import 'pull_to_refresh_controller.dart';

class PullToRefreshBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PullToRefreshController());
  }
}
