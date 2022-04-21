import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_new_post.dart';

import '../../models/post.dart';
import '../../widgets/not_found.dart';
import 'item_user_news_feed.dart';

class LayoutUserNewsFeed extends StatefulWidget {
  LayoutUserNewsFeed({Key? key}) : super(key: key);

  @override
  _LayoutUserNewsFeedState createState() => _LayoutUserNewsFeedState();
}

class _LayoutUserNewsFeedState extends State<LayoutUserNewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(LocaleKeys.NewsFeed.tr),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(ScreenOrganizerNewPost(userType: "user",));
        },
      ),
      body: StreamBuilder(
        stream: postsRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return NotFound(
              message: LocaleKeys.NoInternetConnection.tr,
              assetImage: "assets/images/nothing.png",
            );
          }
          var docs = snapshot.data!.docs;
          // print(docs[0].data());
          List<Post> posts = docs.map((e) => Post.fromMap(e.data() as Map<String, dynamic>)).toList();
          return posts.isNotEmpty
              ? ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (_, index) {
                    return ItemUserNewsFeed(post: posts[index]);
                  })
              : NotFound(
                  message: LocaleKeys.NoPosts.tr,
                );
        },
      ),
    );
  }
}
