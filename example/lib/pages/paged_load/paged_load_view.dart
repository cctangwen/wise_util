import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_paged_load_list.dart';

import 'paged_load_controller.dart';

class PagedLoadPage extends StatelessWidget {
  PagedLoadPage({Key? key}) : super(key: key);

  final controller = Get.find<PagedLoadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("paged load list"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 0,
              child: MaterialButton(
                onPressed: () {
                  controller.onMaterialButtonClick();
                },
                child: Text("111"),
              )),
          Expanded(
            child: WisePagedLoadList<String>(
              key: controller.key,
              shrinkWrap: true,
              future: (params) => controller.fetch(params),
              rowBuilder: (value) {
                return Container(height: 70, child: Text(value));
              },
            ),
          ),
        ],
      ),
    );
  }
}
