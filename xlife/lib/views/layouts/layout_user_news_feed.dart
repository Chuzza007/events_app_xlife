import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/layouts/item_user_news_feed.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_new_post.dart';

class LayoutUserNewsFeed extends StatefulWidget {
  const LayoutUserNewsFeed({Key? key}) : super(key: key);

  @override
  _LayoutUserNewsFeedState createState() =>
      _LayoutUserNewsFeedState();
}

class _LayoutUserNewsFeedState extends State<LayoutUserNewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("News feed"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Get.to(const ScreenOrganizerNewPost());
        },
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index) {
        return const ItemUserNewsFeed();
      }),
    );
  }
}
