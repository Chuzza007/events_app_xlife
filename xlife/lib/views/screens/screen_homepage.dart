import 'package:flutter/material.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/layouts/layout_user_all_events.dart';
import 'package:xlife/views/layouts/layout_user_favorite_events.dart';
import 'package:xlife/views/layouts/layout_user_news_feed.dart';
import 'package:xlife/views/layouts/layout_user_search_events_by_organizers.dart';
import 'package:xlife/widgets/custom_bottom_navigation.dart';
import 'package:xlife/widgets/custom_home_header_container_design.dart';

class ScreenHomepage extends StatefulWidget {
  const ScreenHomepage({Key? key}) : super(key: key);

  @override
  _ScreenHomepageState createState() => _ScreenHomepageState();
}

class _ScreenHomepageState extends State<ScreenHomepage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    LayoutUserAllEvents(),
    LayoutUserSearchEventsByOrganizers(),
    LayoutUserFavoriteEvents(),
    LayoutUserNewsFeed(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomHomeHeaderContainerDesign(
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
        ),
      ),
    );
  }
}
