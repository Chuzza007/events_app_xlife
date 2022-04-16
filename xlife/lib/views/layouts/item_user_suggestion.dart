import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/user.dart';
import 'package:xlife/views/screens/user/screen_user_chat.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class ItemUserSuggestion extends StatefulWidget {
  String userId;


  @override
  State<ItemUserSuggestion> createState() => _ItemUserSuggestionState();

  ItemUserSuggestion({
    required this.userId,
  });
}

class _ItemUserSuggestionState extends State<ItemUserSuggestion> implements ListenerProfileInfo {

  User user = User(full_name: "loading",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "user",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");
  bool userOnline = true;

  @override
  void initState() {
    getProfileInfo(widget.userId, this, "user");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
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
              showBadge: userOnline,
              animationType: BadgeAnimationType.slide,
              child: Container(
                height: Get.height * 0.09,
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        user.image_url ?? userPlaceholder),
                  ),
                ),
              ),
            ),
            Text(
              user.full_name,
              style: (GetPlatform.isWeb ? normal_h4Style_web : normal_h4Style),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.to(ScreenUserChat(mReceiver: user,));
      },
    );
  }

  @override
  void onProfileInfo(User user) {
    if (mounted){
      setState(() {
        this.user = user;
        userOnline = getLastSeen(user.last_seen) == "Online";
      });
    }
  }
}
