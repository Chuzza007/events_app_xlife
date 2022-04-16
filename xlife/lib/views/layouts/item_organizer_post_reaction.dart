import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/reaction.dart';
import 'package:xlife/models/user.dart';

import '../../helpers/styles.dart';

class ItemOrganizerPostReaction extends StatefulWidget {
  Reaction reaction;

  @override
  State<ItemOrganizerPostReaction> createState() => _ItemOrganizerPostReactionState();

  ItemOrganizerPostReaction({
    required this.reaction,
  });
}

class _ItemOrganizerPostReactionState extends State<ItemOrganizerPostReaction> implements ListenerProfileInfo {
  @override
  void initState() {
    getProfileInfo(widget.reaction.user_id, this, "user");
    super.initState();
  }

  User reactionUser = User(
      full_name: "unknown",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      image_url: userPlaceholder,
      last_seen: 0,
      notificationToken: "notificationToken");

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
                color: Colors.black, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(reactionUser.image_url ?? userPlaceholder))),
          ),
          badgeColor: Colors.white,
          position: BadgePosition.bottomEnd(bottom: -(Get.width * 0.005), end: -(Get.width * 0.005)),
          badgeContent: Icon(
            getReactionIcon(),
            size: Get.width * 0.025,
            color: appPrimaryColor,
          ),
        ),
        title: Text(
          reactionUser.full_name,
          style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
        ),
        trailing: Text(
          convertTimeToText(widget.reaction.timestamp, ""),
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  void onProfileInfo(User user) {
    if (mounted) {
      setState(() {
        this.reactionUser = user;
      });
    }
  }

  IconData getReactionIcon() {
    switch (widget.reaction.value) {
      case "dislike":
        return Icons.thumb_down;
      case "love":
        return Icons.favorite;
      default:
        return Icons.thumb_up;
    }
  }
}
