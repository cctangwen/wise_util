import 'package:get/get.dart';

import 'group_paged_load_controller.dart';

class GroupPagedLoadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupPagedLoadController());
  }
}
