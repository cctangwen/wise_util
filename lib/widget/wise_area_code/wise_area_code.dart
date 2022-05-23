import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_box.dart';

import 'wise_area_code_dialog.dart';

class WiseAreaCode extends StatefulWidget {
  final Key? key;
  final String initAreaCode;

  WiseAreaCode({this.key, this.initAreaCode = "+86"}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WiseAreaCodeState();
}

class WiseAreaCodeState extends State<WiseAreaCode> {
  ///被选中的地区代码
  late String _selectAreaCode;

  @override
  void initState() {
    _selectAreaCode = widget.initAreaCode;
    super.initState();
  }

  String getAreaCode() {
    return _selectAreaCode;
  }

  void setAreaCode(String areaCode) {
    setState(() {
      _selectAreaCode = areaCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return WiseAreaCodeDialog(
                onAreaCodeChange: (value) {
                  setState(() {
                    _selectAreaCode = value;
                  });
                },
              );
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WiseBox().wBox16,
          Text(
            _selectAreaCode,
            style: WiseStyle.textStyleLargeBody(),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 20.w,
            color: WiseColor.colorOnSurface(),
          ),
          WiseBox().wBox16,
        ],
      ),
    );
  }
}
