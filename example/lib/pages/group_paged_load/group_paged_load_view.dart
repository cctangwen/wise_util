import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_group_paged_load_list.dart';

import 'group_paged_load_controller.dart';

class GroupPagedLoadPage extends StatelessWidget {
  GroupPagedLoadPage({Key? key}) : super(key: key);

  final controller = Get.find<GroupPagedLoadController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupPagedLoadController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Group Paged Load"),
          ),
          body: Container(
            child: WiseGroupPagedLoadList<String, int>(
              future: (map) async {
                print("map:$map");
                await Future.delayed(Duration(seconds: 1));
                return Future.value([
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                ]);
              },
              group: (string) {
                return int.parse(string) % 3;
              },
              rowBuilder: (value) {
                return Container(height: 70, child: Text(value));
              },
              headerBuilder: (value) {
                return Container(
                    color: Colors.grey,
                    height: 20,
                    child: Text(value.toString()));
              },
            ),
          ),
        );
      },
    );
  }
}