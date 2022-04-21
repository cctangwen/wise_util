import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_localizations.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/util/screen/screen_util.dart';
import 'package:wise_util/widget/wise_area_code/wise_area_code_data.dart';
import 'package:wise_util/widget/wise_multi_state/wise_mulit_state_no_data.dart';
import 'package:wise_util/widget/wise_search_app_bar.dart';

import '../wise_list_tile.dart';

class WiseAreaCodeDialog extends StatefulWidget {
  final Function(String) onAreaCodeChange;

  WiseAreaCodeDialog({required this.onAreaCodeChange});

  @override
  State<StatefulWidget> createState() => _WiseAreaCodeDialogState();
}

class _WiseAreaCodeDialogState extends State {
  ///地区代码列表
  List<Map<String, String>> _areaCodeList = List.empty(growable: true);

  @override
  void initState() {
    _areaCodeList.clear();
    _areaCodeList.addAll(countryCodes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WiseString strings =
        WiseLocalizations.of(context)?.currentLocalization ?? EnWiseString();
    return SingleChildScrollView(
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight -
            ScreenUtil().statusBarHeight -
            ScreenUtil().bottomBarHeight,
        color: WiseColor.colorSurface(),
        child: Column(
          children: [
            Expanded(
                flex: 0,
                child: WiseSearchAppBar(
                  searchChangeAutoCallback: true,
                  appBarColor: WiseColor.colorSurface(),
                  title: Text(strings.selectAreaCodeTitle),
                  onSearchFilter: (value) {
                    _inputSearchTextChange(value);
                  },
                )),
            Expanded(flex: 1, child: _buildAreaCodeDialogList()),
          ],
        ),
      ),
    );
  }

  ///构建对话框的列表
  Widget _buildAreaCodeDialogList() {
    if (_areaCodeList.length == 0) {
      return WiseMultiStateNoData();
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Map<String, String> area = _areaCodeList[index];
        return Column(
          children: [
            WiseListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 2.w, horizontal: 16.w),
              leading: Container(
                width: 0.8.sw,
                child: Text(
                  area["country_name"]!,
                  style: WiseStyle.textStyleLargeBody(),
                ),
              ),
              trailing: Text(
                "+${area["telephone_code"]!}",
                style: WiseStyle.textStyleLargeBody(),
              ),
              onTap: (_) {
                (widget as WiseAreaCodeDialog)
                    .onAreaCodeChange("+${area["telephone_code"]!}");
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Divider(
                height: 1,
              ),
            ),
          ],
        );
      },
      itemCount: _areaCodeList.length,
    );
  }

  ///搜索框输入内容变更监听
  void _inputSearchTextChange(String? text) {
    _areaCodeList.clear();
    if (null == text || text.trim().isEmpty) {
      _areaCodeList.addAll(countryCodes);
    } else {
      String keyWordText = text.trim();

      ///模糊匹配
      countryCodes.forEach((element) {
        if (null != element["country_name"] &&
            element["country_name"]!
                .toLowerCase()
                .contains(keyWordText.toLowerCase())) {
          _areaCodeList.add(element);
        } else if (null != element["country_code"] &&
            element["country_code"]!
                .toLowerCase()
                .contains(keyWordText.toLowerCase())) {
          _areaCodeList.add(element);
        } else if (null != element["telephone_code"] &&
            element["telephone_code"]!.contains(keyWordText)) {
          _areaCodeList.add(element);
        }
      });
    }
    setState(() {});
  }
}
