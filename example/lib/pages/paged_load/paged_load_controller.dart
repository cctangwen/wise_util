import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/widget/wise_loading.dart';
import 'package:wise_util/widget/wise_paged_load_list.dart';

class PagedLoadController extends GetxController {
  final key = GlobalKey<WisePagedLoadListState>();

  Future<List<String>> fetch(Map<String, dynamic> params) async {
    await Future.delayed(Duration(seconds: 10));
    if (params.containsKey("name")) {
      print("有数据");
      return Future.value(["1", "2", "3"]);
    }
    print("没有数据");
    return [];
  }

  void onMaterialButtonClick() async {
    WiseLoading.show();
    await key.currentState!.resetPayload({"name": "Tom"}, replaceAll: false);
    WiseLoading.dismiss();
  }
}
