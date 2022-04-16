import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_admin_news_feed.dart';

class ScreenAdminAllPosts extends StatefulWidget {
  ScreenAdminAllPosts({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllPostsState createState() =>
      _ScreenAdminAllPostsState();
}

class _ScreenAdminAllPostsState extends State<ScreenAdminAllPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Posts"),
      ),
      // body: ListView.builder(
      //     itemCount: 20,
      //     itemBuilder: (context, index){
      //   return ItemAdminNewsFeed();
      // }),
    );
  }
}
