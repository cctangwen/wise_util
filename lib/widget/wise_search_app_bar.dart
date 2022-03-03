import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wise_util/res/wise_color.dart';
import 'package:wise_util/widget/wise_box.dart';

///TODO: 待完善
class WiseSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;

  final Color? backgroundColor;

  WiseSearchAppBar({
    this.title,
    this.backgroundColor,
  });

  @override
  State<StatefulWidget> createState() => _WiseSearchAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _WiseSearchAppBarState extends State<WiseSearchAppBar> {
  Widget? _title;
  bool isSearchStatus = false;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    if (isSearchStatus) {
      return AppBar(
        leading: WiseBox().hBox0,
        title: Container(
          decoration: BoxDecoration(
              color: WiseColor.colorNormalBackground(),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Center(
              child: TextField(
            // focusNode: controller.focusNode,
            // controller: controller.searchTextController,
            // cursorColor: Get.theme.primaryColor,
            textInputAction: TextInputAction.search,
            // onSubmitted: (s)=>controller.onQueryClick(),
            decoration: InputDecoration(
                // hintText: S.current.store_name,
                // hintStyle: appTextStyle.GREY_MEDIUM_STYLE,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(
                    Icons.search,
                    // color: appColor.color_text_grey,
                    size: 20,
                  ),
                ),
                border: InputBorder.none),
          )),
        ),
        backgroundColor: widget.backgroundColor,
      );
    } else {
      return AppBar(
        title: _title,
        backgroundColor: widget.backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchStatus = true;
                });
              },
              icon: Icon(Icons.search_sharp))
        ],
      );
    }
  }
}
