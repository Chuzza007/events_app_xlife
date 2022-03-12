import 'package:flutter/material.dart';

import '../../layouts/item_user_comment.dart';

class ScreenOrganizerPostComments extends StatelessWidget {
  const ScreenOrganizerPostComments({Key? key}) : super(key: key);

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
