import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_event_favorites.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/models/user.dart' as model;

import '../../helpers/styles.dart';
import '../screens/user/screen_user_event_details.dart';

class ItemUserEventByOrganizer extends StatefulWidget {
  Event event;

  @override
  State<ItemUserEventByOrganizer> createState() => _ItemUserEventByOrganizerState();

  ItemUserEventByOrganizer({
    required this.event,
  });
}

class _ItemUserEventByOrganizerState extends State<ItemUserEventByOrganizer> implements ListenerProfileInfo, ListenerEventFavorites {
  model.User organizer = model.User(
      full_name: "full_name",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "organizer",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");

  String distance = "unknown";

  var uid = FirebaseAuth.instance.currentUser!.uid;

  bool favorite = false;

  @override
  void initState() {
    getProfileInfo(widget.event.organizer_id, this, "organizer");
    getEventFavorites(widget.event.id, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ScreenUserEventDetails(
          event: widget.event,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 5.sp, color: Color(0x414D5678))],
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    widget.event.image1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        widget.event.title,
                        style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                      ),
                      dense: true,
                      leading: Icon(Icons.event),
                      subtitle: Text("Organized by ${organizer.full_name}"),
                    ),
                    ListTile(
                      title: Text(
                        distance,
                        style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
                      ),
                      dense: true,
                      leading: Icon(Icons.location_on),
                      subtitle: Text(convertTimeToText(widget.event.startTime, "left")),
                      trailing: IconButton(
                        onPressed: () {
                          updateFavorite(!favorite);
                        },
                        icon: ImageIcon(
                          AssetImage("assets/images/heart_${favorite}.png"),
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onEventFavorites(List<String> users) {
    // TODO: implement onEventFavorites
  }

  @override
  void onMyFavorite(bool favorite) {
    if (mounted) {
      setState(() {
        this.favorite = favorite;
      });
    }
  }

  @override
  void onProfileInfo(model.User user) {
    if (mounted) {
      setState(() {
        organizer = user;
      });
    }
  }

  void updateFavorite(bool status) {
    if (status) {
      eventsRef.doc(widget.event.id).collection("favorites").doc(uid).set({"uid": uid});
      return;
    }
    eventsRef.doc(widget.event.id).collection("favorites").doc(uid).delete();
  }

  void getDistance() {
    if (currentPosition == null) {
      distance = "unknown";
      return;
    }
    setState(() {
      distance =
          "${roundDouble((Geolocator.distanceBetween(currentPosition!.latitude, currentPosition!.longitude, widget.event.latitude, widget.event.longitude) / 1000), 2)} km";
    });
  }
}
