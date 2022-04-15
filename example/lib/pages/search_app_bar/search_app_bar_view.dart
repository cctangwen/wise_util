import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_search_app_bar.dart';

import 'search_app_bar_controller.dart';

class SearchAppBarPage extends StatelessWidget {
  SearchAppBarPage({Key? key}) : super(key: key);

  final controller = Get.find<SearchAppBarController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchAppBarController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: WiseSearchAppBar(
            // searchChangeAutoCallback: true,
            title: Text("123123"),
            onSearchFilter: (value) {
              print("value:$value");
            },
          ),
        );
      },
    );
  }
}
