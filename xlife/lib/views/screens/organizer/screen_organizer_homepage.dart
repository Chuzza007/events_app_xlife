import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/views/layouts/layout_organizer_events.dart';
import 'package:xlife/views/layouts/layout_organizer_news_feed.dart';
import 'package:xlife/widgets/custom_home_header_container_design.dart';
import 'package:xlife/widgets/custom_tab_bar_view.dart';
import '../../../interfaces/listener_profile_info.dart';

class ScreenOrganizerHomepage extends StatefulWidget {
  const ScreenOrganizerHomepage({Key? key}) : super(key: key);

  @override
  _ScreenOrganizerHomepageState createState() => _ScreenOrganizerHomepageState();
}

class _ScreenOrganizerHomepageState extends State<ScreenOrganizerHomepage> with TickerProviderStateMixin implements ListenerProfileInfo {
  List<Widget> organizer_layouts = [const LayoutOrganizerEvents(), const LayoutOrganizerNewsFeed()];
  int selectedIndex = 0;
  String imageUrl = "";

  @override
  void initState() {
    getProfileInfo(FirebaseAuth.instance.currentUser!.uid, this, "organizer");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHomeHeaderContainerDesign(
      type: HomePageType.organizer,
      image_url: imageUrl,
      child: CustomTabBarView(
          tabs_length: 2,
          borderRadius: BorderRadius.circular(30),
          tabs_titles_list: const ["My Events", "News Feed"],
          tabController: TabController(length: 2, vsync: this),
          tab_children_layouts: organizer_layouts),
    );
  }

  @override
  void onProfileInfo(model.User user) {
    if (mounted){
      setState(() {
        imageUrl = user.image_url.toString();
      });
    }
  }
}
