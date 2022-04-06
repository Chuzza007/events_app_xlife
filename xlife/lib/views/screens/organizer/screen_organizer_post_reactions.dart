import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_organizer_post_reaction.dart';

class ScreenOrganizerPostReactions extends StatelessWidget {
  ScreenOrganizerPostReactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("297  Reactions"),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (_, index) {
          return ItemOrganizerPostReaction();
        },
      ),
    );
  }
}
