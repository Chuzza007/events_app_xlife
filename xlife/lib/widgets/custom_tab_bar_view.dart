import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class CustomTabBarView extends StatefulWidget {
  int tabs_length;
  List<String> tabs_titles_list;
  TabController tabController;
  List<Widget> tab_children_layouts;
  BorderRadiusGeometry? borderRadius;
  bool? showTopShadow;
  bool? isScrollable;
  bool? removePadding;

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();

  CustomTabBarView(
      {required this.tabs_length,
      required this.tabs_titles_list,
      required this.tabController,
      required this.tab_children_layouts,
      this.borderRadius,
      this.showTopShadow,
      this.isScrollable,
      this.removePadding});
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TabBar(
            // indicator: BoxDecoration(
            //     color: Colors.redAccent,
            //     borderRadius: BorderRadius.circular(50)),
            controller: widget.tabController,
            unselectedLabelColor: Colors.grey,
            isScrollable: widget.isScrollable ?? false,
            labelColor: Colors.white,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontFamily: "Outfit"),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: appPrimaryColor
            ),
            physics: BouncingScrollPhysics(),
            tabs: getTabBarTitlesToTabs(widget.tabs_titles_list),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: widget.borderRadius,
            boxShadow: (widget.showTopShadow == null ||
                    widget.showTopShadow == true)
                ? [
                    BoxShadow(
                        blurRadius: 10, color: Color(0x414D5678))
                  ]
                : null,
          ),
        ),
        Expanded(
          child: Container(
            padding: (widget.removePadding != null &&
                    widget.removePadding == true)
                ? EdgeInsets.zero
                : EdgeInsets.all(8),
            child: TabBarView(
              controller: widget.tabController,
              children: widget.tab_children_layouts,
            ),
          ),
        )
      ],
    );
  }
}

List<Widget> getTabBarTitlesToTabs(List<String> tabBarTitles) {
  return tabBarTitles
      .map((e) => Tab(
            text: e,
          ))
      .toList();
}
