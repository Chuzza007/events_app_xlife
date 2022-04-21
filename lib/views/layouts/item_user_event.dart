import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/interfaces/listener_event_favorites.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/views/screens/user/screen_user_event_details.dart';

import '../../helpers/constants.dart';
import '../../interfaces/listener_profile_info.dart';
import '../../models/event.dart';

class ItemUserEvent extends StatefulWidget {
  @override
  State<ItemUserEvent> createState() => _ItemUserEventState();
  Event event;

  ItemUserEvent({
    required this.event,
  });
}

class _ItemUserEventState extends State<ItemUserEvent> implements ListenerEventFavorites, ListenerProfileInfo {
  double cardHeight = Get.height * 0.6;

  bool favorite = false;
  String distance = "unknown";
  String uid = FirebaseAuth.instance.currentUser!.uid;
  model.User organizer = model.User(full_name: "Loading",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");

  @override
  void initState() {
    getEventFavorites(widget.event.id, this);
    getProfileInfo(widget.event.organizer_id, this, "organizer");
    getDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool contestExpired =
        widget.event.endTime < DateTime
            .now()
            .millisecondsSinceEpoch;

    return GestureDetector(
      onTap: () {
        Get.to(ScreenUserEventDetails(event: widget.event));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.event.image1,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2.sp,
                    ),
                    Text(
                      distance,
                      style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold).copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      )),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Text(
                        (!contestExpired)
                            ? (widget.event.startTime >
                            DateTime
                                .now()
                                .millisecondsSinceEpoch
                            ? convertTimeToText2(
                            LocaleKeys.StartingFrom.tr, widget.event.startTime, "")
                            : convertTimeToText2(
                            "", widget.event.endTime, LocaleKeys.left.tr))
                            : LocaleKeys.Expired.tr,
                        style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold).copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  height: cardHeight * 0.35,
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          widget.event.title,
                          style: (GetPlatform.isWeb ? heading2_style_web : heading2_style).copyWith(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          widget.event.description,
                          style: (GetPlatform.isWeb ? normal_h2Style_web : normal_h2Style).copyWith(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: true,
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.OrganizedBy.tr,
                              style: normal_h4Style_bold.copyWith(color: Colors.white),
                            ),
                            Expanded(
                              child: Text(
                                " ${organizer.full_name}",
                                overflow: TextOverflow.ellipsis,
                                style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold).copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            updateFavorite(!favorite);
                          },
                          icon: ImageIcon(
                            AssetImage("assets/images/heart_$favorite.png"),
                            color: Colors.white,
                            size: cardHeight * 0.06,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getDistance() {
    if (currentPosition == null) {
      distance = "unknown";
      return;
    }
    if (mounted) {
      setState(() {
        distance =
        "${roundDouble(
            (Geolocator.distanceBetween(currentPosition!.latitude, currentPosition!.longitude, widget.event.latitude, widget.event.longitude) / 1000),
            2)} km";
      });
    }
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

  void updateFavorite(bool status) {
    if (status) {
      eventsRef.doc(widget.event.id).collection("favorites")
          .doc(uid).set({"uid": uid});
      return;
    }
    eventsRef.doc(widget.event.id).collection("favorites")
        .doc(uid).delete();
  }

  @override
  void onProfileInfo(model.User user) {
    if (mounted) {
      setState(() {
        this.organizer = user;
      });
    }
  }

}
