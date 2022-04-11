import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '/res/wise_color.dart';
import '/res/wise_localizations.dart';
import '/res/wise_style.dart';
import '/util/formatter/currency_formatter.dart';
import '/util/screen/screen_size_extension.dart';
import '/util/screen/screen_util.dart';

///数字键盘
class WiseDigitalKeyboard extends StatelessWidget {
  ///点击提交按钮事件
  final Function(String)? onOkPress;

  ///内容变化回调
  final Function(String)? onChange;

  ///是否显示确认按钮
  final bool withOKButton;

  ///是否显示小数按钮。若当前地区显示偏好不存在小数符号，即使设置为true，也不会显示出来
  final bool withDecimalSeparatorButton;

  final int maxIntegerLength;

  String _content = "";

  WiseDigitalKeyboard({
    this.onOkPress,
    this.onChange,
    this.withOKButton = true,
    this.withDecimalSeparatorButton = true,
    this.maxIntegerLength = 8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 235.w,
              padding: EdgeInsets.all(5.w),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topLeft,
              color: WiseColor.colorBackground(),
              child: StaggeredGrid.count(
                crossAxisCount: withOKButton ? 4 : 3,
                crossAxisSpacing: 5.w,
                mainAxisSpacing: 5.w,
                children: withOKButton
                    ? _getOKButtonKeyWidgetList()
                    : _getNoOKButtonKeyWidgetList(),
              )),
          Container(
            width: Get.width,
            height: ScreenUtil().bottomBarHeight,
            color: WiseColor.colorBackground(),
          ),
        ],
      ),
    );
  }

  ///添加内容事件
  _onAddContent(String newChar) {
    String oldValue = _content;
    String decimalSeparator = CurrencyFormatter.getDecimalSeparator();
    int decimalPlaces = CurrencyFormatter.getDecimalPlaces();
    if (oldValue.contains(decimalSeparator) && decimalPlaces > 0) {
      ///若已包含小数点，或者若小数点后位数超过限制位数，不允许再输入
      if ((newChar == decimalSeparator) ||
          (oldValue.split(decimalSeparator)[1].length >= decimalPlaces)) {
        _content = _content;
      } else {
        _content = _content + newChar;
      }
    } else {
      ///整数部分第一位输入小数点时，补0
      if (oldValue == "" && newChar == decimalSeparator) {
        _content = "0.";
      } else if (oldValue == "0" && newChar != decimalSeparator) {
        ///整数部分第一位是0,且输入的新数不是小数点，则删除第一位的0
        _content = "";
      } else if (oldValue.length >= maxIntegerLength &&
          newChar != decimalSeparator) {
        ///整数部分超过maxIntegerLength位，非小数点不再输入
      } else {
        _content = _content + newChar;
      }
    }
    if (null != onChange) onChange!(_content);
  }

  ///减少内容事件
  _onMinusContent() {
    if (_content.length > 0) {
      _content = _content.substring(0, _content.length - 1);
    }
    if (null != onChange) onChange!(_content);
  }

  ///清空内容事件
  _onClearContent() {
    _content = "";
    if (null != onChange) onChange!(_content);
  }

  ///确认内容事件
  _onOKContent() {
    String decimalSeparator = CurrencyFormatter.getDecimalSeparator();
    int decimalPlaces = CurrencyFormatter.getDecimalPlaces();

    ///若最后一位是小数点，删除最后一位
    if (_content.endsWith(decimalSeparator) && decimalPlaces > 0) {
      _onMinusContent();
    }

    ///帮后台把小数分隔符强制转化为小数点
    String value = _content.replaceAll(decimalSeparator, ".");
    if (null != onOkPress) onOkPress!(value);
  }

  ///带OK键盘Widget列表
  List<Widget> _getOKButtonKeyWidgetList() {
    WiseString strings =
        WiseLocalizations.of(Get.context!)?.currentLocalization ??
            EnWiseString();
    List<Widget> widgetList = [];

    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "1",
            onPressed: () {
              _onAddContent("1");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "2",
            onPressed: () {
              _onAddContent("2");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "3",
            onPressed: () {
              _onAddContent("3");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "x",
            isText: false,
            child: Icon(
              Icons.backspace,
              size: 16.w,
              color: Get.isDarkMode ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              _onMinusContent();
            },
            onLongPressed: () {
              _onClearContent();
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "4",
            onPressed: () {
              _onAddContent("4");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "5",
            onPressed: () {
              _onAddContent("5");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "6",
            onPressed: () {
              _onAddContent("6");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
          text: "ok",
          heightMultiple: 3.2,
          color: WiseColor.colorPrimary(),
          isText: false,
          child: Text(
            strings.ok,
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            _onOKContent();
          },
        )));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "7",
            onPressed: () {
              _onAddContent("7");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "8",
            onPressed: () {
              _onAddContent("8");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "9",
            onPressed: () {
              _onAddContent("9");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: (CurrencyFormatter.getDecimalPlaces() > 0 &&
                withDecimalSeparatorButton)
            ? 2
            : 3,
        child: _keySpan(
            text: "0",
            onPressed: () {
              _onAddContent("0");
            })));
    if (CurrencyFormatter.getDecimalPlaces() > 0 &&
        withDecimalSeparatorButton) {
      widgetList.add(StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: _keySpan(
              text: CurrencyFormatter.getDecimalSeparator(),
              onPressed: () {
                _onAddContent(CurrencyFormatter.getDecimalSeparator());
              })));
    }
    return widgetList;
  }

  ///不带OK键盘Widget列表
  List<Widget> _getNoOKButtonKeyWidgetList() {
    List<StaggeredGridTile> widgetList = [];

    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "1",
            onPressed: () {
              _onAddContent("1");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "2",
            onPressed: () {
              _onAddContent("2");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "3",
            onPressed: () {
              _onAddContent("3");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "4",
            onPressed: () {
              _onAddContent("4");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "5",
            onPressed: () {
              _onAddContent("5");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "6",
            onPressed: () {
              _onAddContent("6");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "7",
            onPressed: () {
              _onAddContent("7");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "8",
            onPressed: () {
              _onAddContent("8");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "9",
            onPressed: () {
              _onAddContent("9");
            })));
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: (CurrencyFormatter.getDecimalPlaces() > 0 &&
                withDecimalSeparatorButton)
            ? 1
            : 2,
        child: _keySpan(
            text: "0",
            onPressed: () {
              _onAddContent("0");
            })));
    if (CurrencyFormatter.getDecimalPlaces() > 0 &&
        withDecimalSeparatorButton) {
      widgetList.add(StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: _keySpan(
              text: CurrencyFormatter.getDecimalSeparator(),
              onPressed: () {
                _onAddContent(CurrencyFormatter.getDecimalSeparator());
              })));
    }
    widgetList.add(StaggeredGridTile.fit(
        crossAxisCellCount: 1,
        child: _keySpan(
            text: "x",
            isText: false,
            child: Icon(
              Icons.backspace,
              size: 16.w,
              color: Get.isDarkMode ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              _onMinusContent();
            },
            onLongPressed: () {
              _onClearContent();
            })));
    return widgetList;
  }

  ///绘制单个键盘
  Widget _keySpan(
      {required String text,
      required VoidCallback onPressed,
      VoidCallback? onLongPressed,
      Color? color,
      double heightMultiple = 1.0,
      bool isText = true,
      Widget? child}) {
    return Ink(
      height: 50.w * heightMultiple,
      padding: EdgeInsets.all(0),
      child: MaterialButton(
        color: null == color ? WiseColor.colorSurface() : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        elevation: 0,
        onPressed: () async {
          onPressed();
        },
        onLongPress: onLongPressed,
        child:
            isText ? Text(text, style: WiseStyle.textStyleLargeTitle()) : child,
      ),
    );
  }
}

class WiseDigitalKeyboardUtil {
  ///自定义金额键盘悬浮窗
  static OverlayEntry? _overlayEntry;

  /// 打开键盘
  static showKeyBoard(
    BuildContext context, {
    Function(String)? onOkPress,
    Function(String)? onChange,
    bool withOKButton = true,
    int maxIntegerLength = 8,
  }) {
    if (null == _overlayEntry) {
      _overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
          bottom: 0,
          child: WiseDigitalKeyboard(
            onChange: onChange,
            onOkPress: onOkPress,
            withOKButton: withOKButton,
            maxIntegerLength: maxIntegerLength,
          ),
        );
      });
      Overlay.of(context)!.insert(_overlayEntry!);
    }
  }

  /// 销毁键盘
  static dismissKeyBoard() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
