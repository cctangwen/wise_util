import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wise_util/business/translate/wise_translate_dialog.dart';
import 'package:wise_util/business/translate/wise_translate_service.dart';

class WiseTranslateText extends StatefulWidget {
  String data;

  final String? wordKey;

  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;

  final bool? softWrap;

  final TextOverflow? overflow;

  final double? textScaleFactor;

  final int? maxLines;

  final String? semanticsLabel;

  final TextWidthBasis? textWidthBasis;

  final ui.TextHeightBehavior? textHeightBehavior;

  WiseTranslateText(
    this.data, {
    this.wordKey,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  @override
  State<StatefulWidget> createState() => _WiseTranslateTextState();
}

class _WiseTranslateTextState extends State<WiseTranslateText> {
  late String _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode || !AppTranslateService.getSupportTranslate()) {
      return _buildNormalText();
    } else if (null == widget.wordKey) {
      return _buildNormalText();
    } else {
      return GestureDetector(
        onLongPress: () {
          _showTranslateEditDialog(context, this._data);
        },
        child: _buildEditableText(),
      );
    }
  }

  void _showTranslateEditDialog(BuildContext context, String initValue) {
    TextEditingController textEditingController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return WiseTranslateDialog(
              wordKey: widget.wordKey!,
              initValue: initValue,
              newValue: (value) {
                setState(() {
                  _data = value;
                });
              });
        });
    textEditingController.text = initValue;
  }

  Widget _buildNormalText() {
    return Text(
      widget.data,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
    );
  }

  Widget _buildEditableText() {
    TextStyle? textStyle;
    if (null != widget.style) {
      textStyle = widget.style!.copyWith(
        decoration: TextDecoration.underline,
      );
    } else {
      textStyle = TextStyle(
        decoration: TextDecoration.underline,
      );
    }
    return Text(
      _data,
      style: textStyle,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
    );
  }
}
