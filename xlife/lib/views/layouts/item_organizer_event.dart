import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_event_favorites.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/views/screens/admin/screen_admin_event_details.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_update_event.dart';

import '../../helpers/styles.dart';

class ItemOrganizerEvent extends StatefulWidget {

  Event event;

  @override
  State<ItemOrganizerEvent> createState() => _ItemOrganizerEventState();

  ItemOrganizerEvent({
    required this.event,
  });
}

class _ItemOrganizerEventState extends State<ItemOrganizerEvent> implements ListenerEventFavorites {

  @override
  void initState() {
    getEventFavorites(widget.event.id, this);
    super.initState();
  }

  int favorites = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ScreenAdminEventDetails(event: widget.event, editEnabled: true));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(blurRadius: 5.sp, color: Color(0x414D5678))
          ],
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
                    ),
                    ListTile(
                      title: Text(
                        "$favorites favorites",
                        style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                      ),
                      dense: true,
                      leading: ImageIcon(
                        AssetImage(
                            "assets/images/heart_true.png"),
                        color: Colors.red,
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
    if (mounted){
      setState(() {
        this.favorites = users.length;
      });
    }
  }

  @override
  void onMyFavorite(bool favorite) {
    // TODO: implement onMyFavorite
  }
}
