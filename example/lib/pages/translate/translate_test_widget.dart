import 'package:flutter/cupertino.dart';

class TranslateTestWidget extends StatefulWidget {
  final String initValue;

  TranslateTestWidget({required this.initValue});

  @override
  State<StatefulWidget> createState() => _TranslateTestWidgetState();
}

class _TranslateTestWidgetState extends State<TranslateTestWidget> {
  late String _data;

  @override
  void initState() {
    _data = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.initValue);
  }
}
