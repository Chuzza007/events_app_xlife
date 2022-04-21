import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_events.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/views/layouts/item_admin_event.dart';
import 'package:xlife/widgets/not_found.dart';

class ScreenAdminAllEvents extends StatefulWidget {
  ScreenAdminAllEvents({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllEventsState createState() =>
      _ScreenAdminAllEventsState();
}

class _ScreenAdminAllEventsState extends State<ScreenAdminAllEvents> implements ListenerEvents {

  @override
  void initState() {
    getAllEvents(this);
    super.initState();
  }

  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${LocaleKeys.AllEvents.tr}  (${events.length})"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: events.isNotEmpty ? ListView.builder(
            itemCount: events.length,
            itemBuilder: (_, index) {
          return ItemAdminEvent(event: events[index]);
        }) : NotFound(message: LocaleKeys.NoEventsYet.tr),
      ),
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
