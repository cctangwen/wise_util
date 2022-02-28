import 'package:get/get.dart';

import 'skeleton_controller.dart';

class SkeletonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SkeletonController());
  }
}
