import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_admin_event.dart';

class ScreenAdminAllEvents extends StatefulWidget {
  const ScreenAdminAllEvents({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllEventsState createState() =>
      _ScreenAdminAllEventsState();
}

class _ScreenAdminAllEventsState extends State<ScreenAdminAllEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Events  (20)"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (_, index) {
          return const ItemAdminEvent();
        }),
      ),
    );
  }
}
