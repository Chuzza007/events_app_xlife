import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_event_favorites.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/models/user.dart';
import 'package:xlife/views/screens/admin/screen_admin_event_details.dart';

import '../../helpers/styles.dart';

class ItemAdminEvent extends StatefulWidget {
  Event event;

  @override
  State<ItemAdminEvent> createState() => _ItemAdminEventState();

  ItemAdminEvent({
    required this.event,
  });
}

class _ItemAdminEventState extends State<ItemAdminEvent> implements ListenerEventFavorites, ListenerProfileInfo {
  int favorites = 0;
  User organizer = User(
      full_name: "Unknown",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");

  @override
  void initState() {
    // getEventFavorites(widget.event.id, this);
    getProfileInfo(widget.event.organizer_id, this, "organizer");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                flex: 4,
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
                      trailing: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Delete Event",
                              onConfirm: () async {
                                Get.back();
                                await eventsRef.doc(widget.event.id).delete().then((value) {
                                  Get.snackbar("Alert", "Event deleted", snackPosition: SnackPosition.BOTTOM);
                                });
                              },
                              onCancel: () {},
                              middleText: "Are you sure to delete this event?",
                              textConfirm: "Delete",
                              textCancel: "Cancel");
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "$favorites favorites",
                        style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                      ),
                      dense: true,
                      leading: ImageIcon(
                        AssetImage("assets/images/heart_true.png"),
                        color: Colors.red,
                      ),
                      subtitle: Text("Organized by ${organizer.full_name}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(ScreenAdminEventDetails(event: widget.event, editEnabled: false,));
      },
    );
  }

  @override
  void onEventFavorites(List<String> users) {
    if (mounted){
      setState(() {
        favorites = users.length;
      });
    }
  }

  @override
  void onMyFavorite(bool favorite) {
    // TODO: implement onMyFavorite
  }

  @override
  void onProfileInfo(User user) {
    if (mounted){
      setState(() {
        this.organizer = user;
      });
    }
  }
}
