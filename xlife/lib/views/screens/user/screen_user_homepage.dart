import 'package:flutter/material.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/layouts/layout_user_all_events.dart';
import 'package:xlife/views/layouts/layout_user_favorite_events.dart';
import 'package:xlife/views/layouts/layout_user_news_feed.dart';
import 'package:xlife/views/layouts/layout_user_search_events_by_organizers.dart';
import 'package:xlife/widgets/custom_bottom_navigation.dart';
import 'package:xlife/widgets/custom_home_header_container_design.dart';

class ScreenUserHomepage extends StatefulWidget {
  const ScreenUserHomepage({Key? key}) : super(key: key);

  @override
  _ScreenUserHomepageState createState() => _ScreenUserHomepageState();
}

class _ScreenUserHomepageState extends State<ScreenUserHomepage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const LayoutUserAllEvents(),
    const LayoutUserSearchEventsByOrganizers(),
    const LayoutUserFavoriteEvents(),
    const LayoutUserNewsFeed(),
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
              icon: const ImageIcon(
                  AssetImage("assets/images/multiple_events.png")),
            ),
            CustomBottomMenuItem(
              label: "Search",
              icon: const ImageIcon(
                  AssetImage("assets/images/search_events.png")),
            ),
            CustomBottomMenuItem(
              label: "Favorites",
              icon: const ImageIcon(AssetImage("assets/images/star.png")),
            ),
            CustomBottomMenuItem(
              label: "News Feed",
              icon:
                  const ImageIcon(AssetImage("assets/images/newsfeed.png")),
            ),
          ],
          primaryIndex: 0,
        ), type: HomePageType.user,
      ),
    );
  }
}
