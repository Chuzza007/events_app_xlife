import 'package:flutter/material.dart';
import 'package:xlife/models/comment.dart';

import '../../layouts/item_user_comment.dart';

class ScreenOrganizerPostComments extends StatelessWidget {
  ScreenOrganizerPostComments({Key? key}) : super(key: key);

  List<Comment> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("97 comments"),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (_, index) {
          return ItemUserComment(comment: comments[index],);
        },
      ),
    );
  }
}
