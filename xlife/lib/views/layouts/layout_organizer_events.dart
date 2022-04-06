import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/layouts/item_organizer_event.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_new_event.dart';

import '../../models/event.dart';
import '../../widgets/not_found.dart';

class LayoutOrganizerEvents extends StatefulWidget {
  LayoutOrganizerEvents({Key? key}) : super(key: key);

  @override
  _LayoutOrganizerEventsState createState() => _LayoutOrganizerEventsState();
}

class _LayoutOrganizerEventsState extends State<LayoutOrganizerEvents> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

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
      body: StreamBuilder<QuerySnapshot>(
          stream: eventsRef.where("organizer_id", isEqualTo: uid).snapshots(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return Center(child: CupertinoActivityIndicator());
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return NotFound(
                message: "No Internet Connection",
              );
            }

            var docs = snapshot.data!.docs;

            return docs.length > 0
                ? ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var event = Event.fromMap(docs[index].data() as Map<String, dynamic>);
                      return ItemOrganizerEvent(event: event);
                    },
                  )
                : NotFound(message: "No Data");
          }),
    );
  }
}
