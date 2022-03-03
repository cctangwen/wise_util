import 'package:get/get.dart';

import 'search_app_bar_controller.dart';

class SearchAppBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchAppBarController());
  }
}
