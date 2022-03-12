import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_update_event.dart';

import '../../helpers/styles.dart';
import '../screens/user/screen_user_event_details.dart';

class ItemOrganizerEvent extends StatefulWidget {


  @override
  State<ItemOrganizerEvent> createState() => _ItemOrganizerEventState();


}

class _ItemOrganizerEventState extends State<ItemOrganizerEvent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ScreenOrganizerUpdateEvent());
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
                    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
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
                        "Event title",
                        style: normal_h2Style_bold,
                      ),
                      dense: true,
                      leading: Icon(Icons.event),
                    ),
                    ListTile(
                      title: Text(
                        "22 favorites",
                        style: normal_h3Style,
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
}
