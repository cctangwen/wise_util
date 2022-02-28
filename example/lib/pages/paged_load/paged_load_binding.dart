import 'package:get/get.dart';

import 'paged_load_controller.dart';

class PagedLoadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PagedLoadController());
  }
}
