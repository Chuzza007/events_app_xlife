import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/views/screens/user/screen_user_chat.dart';

import '../../helpers/styles.dart';

class ItemUserSuggestion extends StatelessWidget {
  const ItemUserSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Badge(
              position:
                  BadgePosition.bottomEnd(bottom: 0.sp, end: 6.sp),
              badgeColor: Colors.green,
              toAnimate: false,
              badgeContent: SizedBox(
                height: Get.height * 0.01,
                width: Get.width * 0.01,
              ),
              animationType: BadgeAnimationType.slide,
              child: Container(
                height: Get.height * 0.09,
                width: Get.width * 0.2,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/3/3a/Elton_John_Cannes_2019.jpg"),
                  ),
                ),
              ),
            ),
            Text(
              "Alina",
              style: (GetPlatform.isWeb ? normal_h4Style_web : normal_h4Style),
            ),
          ],
        ),
      ),
      onTap: (){
        Get.to(const ScreenUserChat());
      },
    );
  }
}
