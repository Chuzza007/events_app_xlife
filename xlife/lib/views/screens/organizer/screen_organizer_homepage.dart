import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/layout_organizer_events.dart';
import 'package:xlife/views/layouts/layout_organizer_news_feed.dart';
import 'package:xlife/widgets/custom_home_header_container_design.dart';
import 'package:xlife/widgets/custom_tab_bar_view.dart';

class ScreenOrganizerHomepage extends StatefulWidget {
  const ScreenOrganizerHomepage({Key? key}) : super(key: key);

  @override
  _ScreenOrganizerHomepageState createState() =>
      _ScreenOrganizerHomepageState();
}

class _ScreenOrganizerHomepageState
    extends State<ScreenOrganizerHomepage>
    with TickerProviderStateMixin {
  List<Widget> organizer_layouts = [
    LayoutOrganizerEvents(),
    LayoutOrganizerNewsFeed()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomHomeHeaderContainerDesign(
      type: HomePageType.organizer,
      child: CustomTabBarView(
          tabs_length: 2,
          borderRadius: BorderRadius.circular(30),
          tabs_titles_list: ["My Events", "News Feed"],
          tabController: TabController(length: 2, vsync: this),
          tab_children_layouts: organizer_layouts),
    );
  }
}
