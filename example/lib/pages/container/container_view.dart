import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_container.dart';

import 'container_controller.dart';

class ContainerPage extends StatelessWidget {
  ContainerPage({Key? key}) : super(key: key);

  final controller = Get.find<ContainerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("container"),
      ),
      body: WiseContainer(
        width: 360.w,
        height: 200.w,
        color: Colors.red,
        child: Text("1123"),
      ),
    );
  }
}
