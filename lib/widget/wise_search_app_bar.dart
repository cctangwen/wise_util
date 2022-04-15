import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/res/wise_localizations.dart';
import 'package:wise_util/widget/wise_box.dart';

class WiseSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;

  final Color? appBarColor;

  final Color? textFiledColor;

  final Function(String?) onSearchFilter;

  final bool searchChangeAutoCallback;

  WiseSearchAppBar({
    required this.onSearchFilter,
    this.title,
    this.appBarColor,
    this.textFiledColor,
    this.searchChangeAutoCallback = false,
  });

  @override
  State<StatefulWidget> createState() => _WiseSearchAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _WiseSearchAppBarState extends State<WiseSearchAppBar> {
  Widget? _title;
  bool isSearchStatus = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  _changeSearchStatus(bool value) {
    setState(() {
      isSearchStatus = value;
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isSearchStatus) {
      WiseString strings =
          WiseLocalizations.of(context)?.currentLocalization ?? EnWiseString();
      return AppBar(
        backgroundColor: widget.appBarColor,
        leading: IconButton(
          onPressed: () {
            widget.onSearchFilter(null);
            _changeSearchStatus(false);
          },
          icon: Icon(
            Icons.clear,
            color: WiseColor.colorOnSurface(),
          ),
        ),
        actions: [
          Visibility(
            visible: !widget.searchChangeAutoCallback,
            child: IconButton(
              onPressed: () {
                String searchFilter = textEditingController.text.trim();
                if (searchFilter.isNotEmpty)
                  widget.onSearchFilter(searchFilter);
              },
              icon: Icon(
                Icons.search,
                color: WiseColor.colorPrimary(),
              ),
            ),
          ),
        ],
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.textFiledColor ??
                WiseColor.colorSurfaceVariant().withOpacity(0.38),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: TextField(
            controller: textEditingController,
            textInputAction: TextInputAction.search,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: strings.selectAreaCodeSearch,
              prefix: WiseBox().wBox16,
            ),
            onChanged: (value) {
              if (widget.searchChangeAutoCallback && value.isNotEmpty)
                widget.onSearchFilter(value);
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) widget.onSearchFilter(value);
            },
          ),
        ),
      );
    } else {
      return AppBar(
        title: _title,
        backgroundColor: widget.appBarColor,
        actions: [
          IconButton(
            onPressed: () {
              _changeSearchStatus(true);
            },
            icon: Icon(Icons.search_sharp),
          ),
        ],
      );
    }
  }
}
