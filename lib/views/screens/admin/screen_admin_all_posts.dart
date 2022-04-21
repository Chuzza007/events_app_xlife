import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/views/layouts/item_admin_news_feed.dart';

import '../../../widgets/not_found.dart';

class ScreenAdminAllPosts extends StatefulWidget {
  ScreenAdminAllPosts({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllPostsState createState() => _ScreenAdminAllPostsState();
}

class _ScreenAdminAllPostsState extends State<ScreenAdminAllPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.AllPosts.tr),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsRef.snapshots(),
        builder: (context, snapshot) {
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
          List<Post> posts = snapshot.data!.docs.map((e) => Post.fromMap(e.data() as Map<String, dynamic>)).toList();
          
          return posts.isNotEmpty ? ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return ItemAdminNewsFeed(
                post: posts[index],
              );
            },
          ) : NotFound(message: LocaleKeys.NoPosts.tr,);
        },
      ),
    );
  }
}
