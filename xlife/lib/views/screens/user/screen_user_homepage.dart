import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/fcm.dart';
import 'package:xlife/views/layouts/layout_user_all_events.dart';
import 'package:xlife/views/layouts/layout_user_favorite_events.dart';
import 'package:xlife/views/layouts/layout_user_news_feed.dart';
import 'package:xlife/views/layouts/layout_user_search_events_by_organizers.dart';
import 'package:xlife/widgets/custom_bottom_navigation.dart';
import 'package:xlife/widgets/custom_home_header_container_design.dart';

class ScreenUserHomepage extends StatefulWidget {
  ScreenUserHomepage({Key? key}) : super(key: key);

  @override
  _ScreenUserHomepageState createState() => _ScreenUserHomepageState();
}

class _ScreenUserHomepageState extends State<ScreenUserHomepage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    LayoutUserAllEvents(),
    LayoutUserSearchEventsByOrganizers(),
    LayoutUserFavoriteEvents(),
    LayoutUserNewsFeed(),
  ];
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    updateLastSeenAndToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomHomeHeaderContainerDesign(
        image_url: "",
        child: pages[selectedIndex],
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          showSelectedLabels: false,
          type: CustomBottomNavigationType.animating,
          showUnselectedLabels: false,
          selectedItemColor: appPrimaryColor,
          unselectedItemColor: Colors.black26,
          items: [
            CustomBottomMenuItem(
              label: "Nearby Events",
              icon: ImageIcon(
                  AssetImage("assets/images/multiple_events.png")),
            ),
            CustomBottomMenuItem(
              label: "Search",
              icon: ImageIcon(
                  AssetImage("assets/images/search_events.png")),
            ),
            CustomBottomMenuItem(
              label: "Favorites",
              icon: ImageIcon(AssetImage("assets/images/star.png")),
            ),
            CustomBottomMenuItem(
              label: "News Feed",
              icon:
                  ImageIcon(AssetImage("assets/images/newsfeed.png")),
            ),
          ],
          primaryIndex: 0,
        ), type: HomePageType.user,
      ),
    );
  }

  Future<void> updateLastSeenAndToken() async {
    int last_seen = DateTime.now().millisecondsSinceEpoch;
    String? token = await FCM.generateToken();
    usersRef.doc(uid).update({"last_seen":last_seen, "notificationToken":token});
    Timer.periodic(const Duration(minutes: 10), (timer) async {
      int last_seen = DateTime.now().millisecondsSinceEpoch;
      usersRef.doc(uid).update({"last_seen":last_seen});
    });
  }
}
