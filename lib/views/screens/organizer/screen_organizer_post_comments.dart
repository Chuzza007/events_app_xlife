import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/models/comment.dart';

import '../../layouts/item_user_comment.dart';

class ScreenOrganizerPostComments extends StatelessWidget {
  ScreenOrganizerPostComments({Key? key}) : super(key: key);

  List<Comment> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.NComments.replaceFirst("00", "97")),
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
