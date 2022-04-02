import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_user_event_by_organizer.dart';

class LayoutUserFavoriteEvents extends StatefulWidget {
  const LayoutUserFavoriteEvents({Key? key}) : super(key: key);

  @override
  _LayoutUserFavoriteEventsState createState() =>
      _LayoutUserFavoriteEventsState();
}

class _LayoutUserFavoriteEventsState
    extends State<LayoutUserFavoriteEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Liked Events"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ItemUserEventByOrganizer(favorite: true);
        },
      ),
    );
  }
}
