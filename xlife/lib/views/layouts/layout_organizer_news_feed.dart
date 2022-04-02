import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_new_post.dart';

import 'item_organizer_news_feed.dart';

class LayoutOrganizerNewsFeed extends StatefulWidget {
  const LayoutOrganizerNewsFeed({Key? key}) : super(key: key);

  @override
  _LayoutOrganizerNewsFeedState createState() =>
      _LayoutOrganizerNewsFeedState();
}

class _LayoutOrganizerNewsFeedState
    extends State<LayoutOrganizerNewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(const ScreenOrganizerNewPost());
        },
        label: const Text("Post"),
        icon: const Icon(Icons.add),
        tooltip: "Add new Post",
      ),

      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index){
        return const ItemOrganizerNewsFeed();
      }),
    );
  }
}
