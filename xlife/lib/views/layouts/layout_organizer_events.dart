import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/layouts/item_organizer_event.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_new_event.dart';
import 'package:xlife/widgets/custom_listview_builder.dart';

class LayoutOrganizerEvents extends StatefulWidget {
  const LayoutOrganizerEvents({Key? key}) : super(key: key);

  @override
  _LayoutOrganizerEventsState createState() =>
      _LayoutOrganizerEventsState();
}

class _LayoutOrganizerEventsState
    extends State<LayoutOrganizerEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(ScreenOrganizerNewEvent());
        },
        label: Text("Event"),
        icon: Icon(Icons.add),
        tooltip: "Add new Event",
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ItemOrganizerEvent();
        },
      ),
    );
  }
}
