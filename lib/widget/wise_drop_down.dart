import 'package:flutter/material.dart';

class WiseDropDown<T> extends StatefulWidget {
  ///输入装饰
  final InputDecoration decoration;

  ///将下拉列表的内部内容设置为水平填充其父级。
  ///默认情况下，此按钮的内部宽度是其内容的最小大小。
  ///如果[isExpanded]为真，则内部宽度将扩展以填充其内部宽度周围的容器。
  final bool isExpanded;

  ///通过下拉按钮显示的占位提示。
  final Widget? hint;

  ///默认情况下，此按钮的高度与其菜单项的高度相同。
  ///如果isDense是真的，按钮的高度会减少一半左右。
  final bool isDense;

  ///用于下拉按钮和下拉列表中文本的文本样式
  ///点击按钮时出现的菜单。
  final TextStyle? style;

  ///下拉菜单菜单项
  final List<DropdownMenuItem<T>> items;

  ///阴影高度
  ///默认8
  final int elevation;

  ///下拉按钮图标尺寸
  ///默认24
  final double iconSize;

  ///下拉按钮图标
  ///默认使用 [Icons.arrow_drop_down].
  final Widget? icon;

  ///初始化值
  final T? initialValue;

  WiseDropDown({
    this.hint,
    this.style,
    required this.items,
    this.initialValue,
    this.isDense = true,
    this.isExpanded = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.icon,
    this.decoration = const InputDecoration(),
  });

  @override
  State<StatefulWidget> createState() => _WiseDropDownState<T>();
}

class _WiseDropDownState<T> extends State<WiseDropDown> {
  T? _value;

  @override
  void initState() {
    if (null != widget.initialValue) {
      _value = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: widget.decoration,
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: _value,
                isExpanded: widget.isExpanded,
                hint: widget.hint,
                style: widget.style,
                isDense: widget.isDense,
                elevation: widget.elevation,
                iconSize: widget.iconSize,
                icon: widget.icon,
                items: (widget as WiseDropDown<T>).items,
                onChanged: (v) {
                  setState(() {
                    _value = v;
                  });
                  print(v);
                },
              ),
            ),
          ),
          ...[
            const VerticalDivider(),
            InkWell(
              onTap: () => setState(() {
                _value = null;
              }),
              child: Icon(Icons.close),
            ),
          ]
        ],
      ),
    );
  }
}
