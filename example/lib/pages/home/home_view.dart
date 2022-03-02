import 'package:example/router/app_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/business/update/app_update_service.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_button.dart';
import 'package:wise_util/widget/wise_loading.dart';
import 'package:wise_util/widget/wise_toast.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("example"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              width: Get.width,
              height: Get.height,
              color: WiseColor.colorNormalBackground(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUtil(),
                  WiseBox().hBox20,
                  _buildWidget(context),
                  WiseBox().hBox20,
                  _buildRes(),
                  WiseBox().hBox20,
                  _buildBusiness(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUtil() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Util",
          style: WiseStyle.textStyleTitle(),
        ),
        Wrap(
          spacing: 16,
          children: [
            WiseButton.primaryButton("http request", onPressed: () async {
              controller.sendHttpRequest();
            }),
            WiseButton.primaryButton("formatter", onPressed: () async {
              Get.toNamed(AppRoute.pageFormatter);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildRes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Res",
          style: WiseStyle.textStyleTitle(),
        ),
        Wrap(
          spacing: 16,
          children: [
            WiseButton.primaryButton("switch theme", onPressed: () {
              controller.switchTheme();
            }),
            WiseButton.primaryButton("text style", onPressed: () {
              Get.toNamed(AppRoute.pageStyle);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Widget",
          style: WiseStyle.textStyleTitle(),
        ),
        Wrap(
          spacing: 16,
          children: [
            WiseButton.primaryButton("showLoading", onPressed: () async {
              WiseLoading.show();
              await Future.delayed(Duration(seconds: 3));
              WiseLoading.dismiss();
            }),
            WiseButton.primaryButton("keyboard", onPressed: () async {
              Get.toNamed(AppRoute.pageKeyboard);
            }),
            WiseButton.primaryButton("multi state", onPressed: () async {
              Get.toNamed(AppRoute.pageMultiState);
            }),
            WiseButton.primaryButton("pull to refresh", onPressed: () async {
              Get.toNamed(AppRoute.pagePullToRefresh);
            }),
            WiseButton.primaryButton("paged load list", onPressed: () async {
              Get.toNamed(AppRoute.pagePagedLoad);
            }),
            WiseButton.primaryButton("group paged load list",
                onPressed: () async {
              Get.toNamed(AppRoute.pageGroupPagedLoad);
            }),
            WiseButton.primaryButton("skeleton", onPressed: () async {
              Get.toNamed(AppRoute.pageSkeleton);
            }),
            WiseButton.primaryButton("avatar", onPressed: () async {
              Get.toNamed(AppRoute.pageAvatar);
            }),
            WiseButton.primaryButton("successToast", onPressed: () async {
              WiseToast.successToast(context, 'ppsp');
            }),
            WiseButton.primaryButton("failToast", onPressed: () async {
              WiseToast.failToast(context, 'ppsp');
            }),
            WiseButton.primaryButton("infoToast", onPressed: () async {
              WiseToast.infoToast(context, 'ppsp');
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildBusiness() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business",
          style: WiseStyle.textStyleTitle(),
        ),
        Wrap(
          spacing: 16,
          children: [
            WiseButton.primaryButton("update", onPressed: () async {
              AppUpdateService.checkUpdate();
            }),
          ],
        ),
      ],
    );
  }
}
