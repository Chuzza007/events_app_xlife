import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_post_details.dart';
import 'package:xlife/models/comment.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/models/reaction.dart';
import 'package:xlife/models/user.dart';

import '../../layouts/item_user_comment.dart';

class ScreenOrganizerPostComments extends StatefulWidget {
  Post post;


  @override
  State<ScreenOrganizerPostComments> createState() => _ScreenOrganizerPostCommentsState();

  ScreenOrganizerPostComments({
    required this.post,
  });
}

class _ScreenOrganizerPostCommentsState extends State<ScreenOrganizerPostComments> implements
ListenerPostDetails {
  List<Comment> comments = [];

  @override
  void initState() {
    getPostDetails(widget.post, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.NComments.replaceFirst("00", comments.length.toString())),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (_, index) {
          return ItemUserComment(comment: comments[index],);
        },
      ),
    );
  }

  @override
  void onComments(List<Comment> comments) {
    if (mounted){
      setState(() {
        this.comments = comments;
      });
    }
  }

  @override
  void onMyReaction(String? reaction) {
    // TODO: implement onMyReaction
  }

  @override
  void onReactions(List<Reaction> reactions) {
    // TODO: implement onReactions
  }

  @override
  void onUserListener(User user) {
    // TODO: implement onUserListener
  }
}
