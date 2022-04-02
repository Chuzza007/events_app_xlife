import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/views/screens/admin/screen_admin_event_details.dart';

import '../../helpers/styles.dart';

class ItemAdminEvent extends StatelessWidget {
  const ItemAdminEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(blurRadius: 5.sp, color: const Color(0x414D5678))
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
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
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Event title",
                        style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                      ),
                      dense: true,
                      leading: const Icon(Icons.event),
                      trailing: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Delete Event",
                              onConfirm: () {},
                              onCancel: () {},
                              middleText:
                                  "Are you sure to delete this event?",
                              textConfirm: "Delete",
                              textCancel: "Cancel");
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "22 favorites",
                        style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                      ),
                      dense: true,
                      leading: const ImageIcon(
                        AssetImage("assets/images/heart_true.png"),
                        color: Colors.red,
                      ),
                      subtitle: const Text("Organized by ####"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(const ScreenAdminEventDetails());
      },
    );
  }
}
