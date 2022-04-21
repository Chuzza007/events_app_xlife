import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/interfaces/listener_events.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/views/layouts/item_user_event_by_organizer.dart';
import 'package:xlife/widgets/not_found.dart';

import '../../generated/locales.g.dart';
import '../../helpers/constants.dart';

class LayoutUserFavoriteEvents extends StatefulWidget {
  LayoutUserFavoriteEvents({Key? key}) : super(key: key);

  @override
  _LayoutUserFavoriteEventsState createState() =>
      _LayoutUserFavoriteEventsState();
}

class _LayoutUserFavoriteEventsState
    extends State<LayoutUserFavoriteEvents> implements ListenerEvents{

  List<Event> events = [];
  @override
  void initState() {
    getMyFavoriteEvents(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(LocaleKeys.LikedEvents.tr),
      ),
      body: events.isNotEmpty ? ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ItemUserEventByOrganizer( event: events[index]);
        },
      ) : NotFound(message: LocaleKeys.NoFavorites.tr),
    );
  }

  @override
  void onEventAdded(List<Event> events) {
    if (mounted){
      setState(() {
        this.events = events;
      });
    }
  }
}
