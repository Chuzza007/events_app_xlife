import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';

import '../../helpers/styles.dart';

class ItemOrganizerPostReaction extends StatelessWidget {
  const ItemOrganizerPostReaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: appBoxShadow,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(5.sp),
      padding: EdgeInsets.all(5.sp),
      child: ListTile(
        leading: Badge(
          child: Container(
            height: 10.h,
            width: 15.w,
            decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://hireme.ga/images/mubashar.png"))),
          ),
          badgeColor: Colors.white,
          position: BadgePosition.bottomEnd(
              bottom: -(Get.width * 0.005),
              end: -(Get.width * 0.005)),
          badgeContent: Icon(
            Icons.thumb_up,
            size: Get.width * 0.025,
            color: appPrimaryColor,
          ),
        ),
        title: Text(
          "Mubashar Hussain",
          style: normal_h3Style_bold,
        ),
        trailing: Text(
          "1 h",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
