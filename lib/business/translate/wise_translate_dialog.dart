import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wise_util/business/translate/wise_translate_service.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_style.dart';
import 'package:wise_util/util/screen/screen_size_extension.dart';
import 'package:wise_util/widget/wise_box.dart';
import 'package:wise_util/widget/wise_button.dart';

class WiseTranslateDialog extends StatefulWidget {
  final String wordKey;

  final String initValue;

  final Function(String) newValue;

  WiseTranslateDialog(
      {required this.wordKey, required this.initValue, required this.newValue});

  @override
  State<StatefulWidget> createState() => _WiseTranslateDialogState();
}

class _WiseTranslateDialogState extends State<WiseTranslateDialog> {
  TextEditingController textEditingController = TextEditingController();

  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.initValue;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      padding: EdgeInsets.all(16.w),
      color: WiseColor.colorSurface(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.language_outlined,
              ),
              WiseBox().wBox4,
              Text(
                "Translate",
                style: WiseStyle.textStyleLargeBody(),
              ),
            ],
          ),
          WiseBox().hBox16,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Page:${Get.currentRoute.split('?')[0]}",
              style: WiseStyle.textStyleMediumLabel(),
              textAlign: TextAlign.start,
            ),
          ),
          WiseBox().hBox8,
          TextField(
            controller: textEditingController,
            autofocus: true,
            maxLines: 4,
            style: WiseStyle.textStyleMediumBody(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: WiseColor.colorSurfaceVariant(), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: WiseColor.colorPrimary(), width: 1),
              ),
            ),
          ),
          WiseBox().hBox16,
          Visibility(
            replacement: Align(
                alignment: Alignment.centerRight,
                child: CircularProgressIndicator()),
            visible: isFetching == false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WiseButton.secondaryButton("Cancel", height: 40.w,
                    onPressed: () {
                  Navigator.of(context).pop();
                }),
                WiseBox().wBox16,
                WiseButton.primaryButton("OK", height: 40.w,
                    onPressed: () async {
                  setState(() {
                    isFetching = true;
                  });
                  String newValue = textEditingController.text;
                  var resp = await AppTranslateService.submitWord(
                      widget.wordKey, newValue, widget.initValue);
                  if (resp) {
                    widget.newValue(newValue);
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      isFetching = false;
                    });
                  }
                }),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
