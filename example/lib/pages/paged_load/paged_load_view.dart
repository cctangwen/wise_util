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
      body: Container(
        child: WisePagedLoadList<String>(
          future: (map) async {
            print("map:$map");
            await Future.delayed(Duration(seconds: 3));
            return Future.value(["1", "2", "3"]);
          },
          payload: {"name": "Tom"},
          rowBuilder: (value) {
            return Container(height: 70, child: Text(value));
          },
        ),
      ),
    );
  }
}
