import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/user.dart';

import '../../helpers/styles.dart';

class ItemAdminEventFavorite extends StatefulWidget {

  String userId;


  @override
  _ItemAdminEventFavoriteState createState() =>
      _ItemAdminEventFavoriteState();

  ItemAdminEventFavorite({
    required this.userId,
  });
}

class _ItemAdminEventFavoriteState extends State<ItemAdminEventFavorite> implements ListenerProfileInfo {

  User user = User(full_name: "Unknown",
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
    getProfileInfo(widget.userId, this, "user");
    super.initState();
  }

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
        leading: Container(
          height: 10.h,
          width: 15.w,
          decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      user.image_url ?? userPlaceholder))),
        ),
        title: Text(
          user.full_name,
          style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
        ),
      ),
    );
  }

  @override
  void onProfileInfo(User user) {
    if (mounted){
      setState(() {
        this.user = user;
      });
    }
  }
}
