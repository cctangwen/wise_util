import 'package:example/router/app_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wise_util/business/update/app_update_service.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/permission_util.dart';
import 'package:wise_util/widget/wise_alert_dialog/wise_alert_dialog.dart';
import 'package:wise_util/widget/wise_area_code/wise_area_code.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_button.dart';
import 'package:wise_util/widget/wise_loading.dart';
import 'package:wise_util/widget/wise_tag.dart';
import 'package:wise_util/widget/wise_toast.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  final _formKey = GlobalKey<FormBuilderState>();

  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "example",
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            width: Get.width,
            height: Get.height,
            color: WiseColor.colorSurface(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUtil(context),
                  WiseBox().hBox20,
                  WiseTag(
                    text: "Online",
                    color: Colors.green,
                  ),
                  WiseBox().hBox20,
                  _buildWidget(context),
                  WiseBox().hBox20,
                  _buildRes(),
                  WiseBox().hBox20,
                  _buildBusiness(),
                  TextField(
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton(
                          hint: Text("please select"),
                          items: [
                            DropdownMenuItem<String>(
                                value: "11", child: Text("aa")),
                            DropdownMenuItem<String>(
                                value: "22", child: Text("bb")),
                            DropdownMenuItem<String>(
                                value: "33", child: Text("cc")),
                            DropdownMenuItem<String>(
                                value: "44", child: Text("dd")),
                          ],
                          onChanged: (a) {
                            print(a);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUtil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Util",
          style: WiseStyle.textStyleLargeTitle(),
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
            WiseButton.primaryButton("permission", onPressed: () async {
              var result = await PermissionUtil.checkPermission(
                  Permission.storage, context, "快去开启存储权限");
              if (result) {
                WiseToast.shortToast("权限已开启");
              } else {
                WiseToast.shortToast("权限已关闭");
              }
            }),
          ],
        ),
        WiseAreaCode(),
      ],
    );
  }

  Widget _buildRes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Res",
          style: WiseStyle.textStyleLargeTitle(),
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
          style: WiseStyle.textStyleLargeTitle(),
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
            WiseButton.primaryButton("shortToast", onPressed: () async {
              WiseToast.shortToast('ppsp');
            }),
            WiseButton.primaryButton("longToast", onPressed: () async {
              WiseToast.longToast('ppsp');
            }),
            WiseButton.primaryButton("searchAppBar", onPressed: () async {
              Get.toNamed(AppRoute.pageSearchAppBar);
            }),
            WiseButton.primaryButton("ok alert dialog", onPressed: () async {
              var a = await showWiseOkAlertDialog(
                  context: context, title: "Title", message: "woshi1xiaosi1");
              print("a:$a");
            }),
            WiseButton.primaryButton("ok cancel alert dialog",
                onPressed: () async {
              var a = await showWiseOkCancelAlertDialog(
                context: context,
                title: "Title",
                message: "woshi1xiaosi1",
                defaultType: OkCancelAlertDefaultType.ok,
                isDestructiveAction: true,
              );
              print("a:$a");
            }),
            WiseButton.primaryButton("container", onPressed: () async {
              Get.toNamed(AppRoute.pageContainer);
            }),
            WiseButton.primaryButton("translate", onPressed: () async {
              Get.toNamed(AppRoute.pageTranslate);
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
          style: WiseStyle.textStyleLargeTitle(),
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
