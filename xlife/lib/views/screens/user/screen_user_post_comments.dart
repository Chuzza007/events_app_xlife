import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_user_comment.dart';

class ScreenUserPostComments extends StatefulWidget {
  const ScreenUserPostComments({Key? key}) : super(key: key);

  @override
  _ScreenUserPostCommentsState createState() =>
      _ScreenUserPostCommentsState();
}

class _ScreenUserPostCommentsState
    extends State<ScreenUserPostComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("97 comments"),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (_, index) {
          return ItemUserComment();
        },
      ),
    );
  }
}
