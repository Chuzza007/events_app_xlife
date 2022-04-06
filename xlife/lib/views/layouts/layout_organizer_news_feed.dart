import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_new_post.dart';

import '../../widgets/not_found.dart';
import 'item_organizer_news_feed.dart';

class LayoutOrganizerNewsFeed extends StatefulWidget {
  LayoutOrganizerNewsFeed({Key? key}) : super(key: key);

  @override
  _LayoutOrganizerNewsFeedState createState() =>
      _LayoutOrganizerNewsFeedState();
}

class _LayoutOrganizerNewsFeedState
    extends State<LayoutOrganizerNewsFeed> {

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(ScreenOrganizerNewPost());
        },
        label: Text("Post"),
        icon: Icon(Icons.add),
        tooltip: "Add new Post",
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: postsRef.where("user_id", isEqualTo: uid).snapshots(),
          builder: (context, snapshot){


            if (!snapshot.hasData) {
              return Center(child: CupertinoActivityIndicator());
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return NotFound(
                message: "No Internet Connection",
              );
            }

            var docs = snapshot.data!.docs;
            print(docs);

            return docs.length > 0 ? ListView.builder(
                itemCount: docs.length,
                itemBuilder: (_, index){

                  var post = Post.fromMap(docs[index].data() as Map<String, dynamic>);

                  return ItemOrganizerNewsFeed(post: post);
                }) : NotFound(message: "No posts");
          }),
    );
  }
}
