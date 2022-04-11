import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/config/wise_config.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/formatter/currency_formatter.dart';
import 'package:wise_util/util/formatter/datetime_formatter.dart';
import 'package:wise_util/util/formatter/number_formatter.dart';

import 'formatter_controller.dart';

class FormatterPage extends StatelessWidget {
  FormatterPage({Key? key}) : super(key: key);

  final controller = Get.find<FormatterController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormatterController>(
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("格式化"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSetting(),
                SizedBox(
                  height: 20,
                ),
                _buildCurrency(),
                SizedBox(
                  height: 20,
                ),
                _buildNumber(),
                SizedBox(
                  height: 20,
                ),
                _buildDatetime(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrency() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Currency formatter",
          style: WiseStyle.textStyleLargeTitle(),
        ),
        Text(
          CurrencyFormatter.format(123456, showSymbol: true),
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          CurrencyFormatter.format(123456, showSymbol: false),
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "货币符号:     ${CurrencyFormatter.getSymbol()}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "小数分隔符:     ${CurrencyFormatter.getDecimalSeparator()}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "小数位数:     ${CurrencyFormatter.getDecimalPlaces()}",
          style: WiseStyle.textStyleMediumBody(),
        ),
      ],
    );
  }

  Widget _buildNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Number formatter",
          style: WiseStyle.textStyleLargeTitle(),
        ),
        Text(
          NumberFormatter.format(456789),
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          NumberFormatter.format(0.1, isPercent: true),
          style: WiseStyle.textStyleMediumBody(),
        ),
      ],
    );
  }

  Widget _buildDatetime() {
    var now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Datetime formatter",
          style: WiseStyle.textStyleLargeTitle(),
        ),
        Text(
          "${DatetimeFormatter.formatDateYMMM(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatDateYMMMD(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatYMMMDJM(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatYMMMDJMS(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatYMMMDHM(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatYMMMDHMS(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatJM(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatJMS(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatHM(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
        Text(
          "${DatetimeFormatter.formatHMS(now)}",
          style: WiseStyle.textStyleMediumBody(),
        ),
      ],
    );
  }

  Widget _buildSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "当前货币类型:   ",
              style: WiseStyle.textStyleMediumBody(),
            ),
            OutlinedButton(
              onPressed: () {
                if ("USD" == WiseConfig.getCurrency()) {
                  WiseConfig.setCurrency("NGN");
                } else {
                  WiseConfig.setCurrency("USD");
                }
                controller.update();
              },
              child: Text(WiseConfig.getCurrency()),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "当前地区偏好:   ",
              style: WiseStyle.textStyleMediumBody(),
            ),
            OutlinedButton(
              onPressed: () {
                if ("en-US" == WiseConfig.getRegion()) {
                  WiseConfig.setRegion("fr-FR");
                } else {
                  WiseConfig.setRegion("en-US");
                }
                controller.update();
              },
              child: Text(WiseConfig.getRegion()),
            ),
          ],
        ),
      ],
    );
  }
}
