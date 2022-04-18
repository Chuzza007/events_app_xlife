import 'package:flutter/material.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_event_favorites.dart';
import 'package:xlife/interfaces/listener_post_details.dart';
import 'package:xlife/models/comment.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/models/reaction.dart';
import 'package:xlife/models/user.dart';
import 'package:xlife/views/layouts/item_organizer_post_reaction.dart';

class ScreenOrganizerPostReactions extends StatefulWidget {

  Post post;


  @override
  State<ScreenOrganizerPostReactions> createState() => _ScreenOrganizerPostReactionsState();

  ScreenOrganizerPostReactions({
    required this.post,
  });

}

class _ScreenOrganizerPostReactionsState extends State<ScreenOrganizerPostReactions> implements ListenerPostDetails {

  @override
  void initState() {
    getPostDetails(widget.post, this);
    super.initState();
  }
  List<Reaction> reactions =[];
  int numReactions = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$numReactions  Reactions"),
      ),
      body: ListView.builder(
        itemCount: reactions.length,
        itemBuilder: (_, index) {
          return ItemOrganizerPostReaction(reaction: reactions[index]);
        },
      ),
    );
  }

  @override
  void onComments(List<Comment> comments) {
    // TODO: implement onComments
  }

  @override
  void onMyReaction(String? reaction) {
    // TODO: implement onMyReaction
  }

  @override
  void onReactions(List<Reaction> reactions) {
    if (mounted){
      setState(() {
        numReactions = reactions.length;
        this.reactions = reactions;
      });
    }
  }

  @override
  void onUserListener(User user) {
    // TODO: implement onUserListener
  }

}
