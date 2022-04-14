import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/comment.dart';
import 'package:xlife/models/user.dart' as model;

import '../../helpers/styles.dart';
import '../../interfaces/listener_profile_info.dart';

class ItemUserComment extends StatefulWidget {

  Comment comment;

  @override
  _ItemUserCommentState createState() => _ItemUserCommentState();

  ItemUserComment({
    required this.comment,
  });
}

class _ItemUserCommentState extends State<ItemUserComment> implements ListenerProfileInfo {

  var user = model.User(full_name: "Unknow User",
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
    getProfileInfo(FirebaseAuth.instance.currentUser!.uid, this, "user");
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
        subtitle: Text(
          widget.comment.text,
          style: (GetPlatform.isWeb ? normal_h4Style_web : normal_h4Style),
        ),
        trailing: Text(
          convertTimeToText(widget.comment.timestamp, ""),
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  void onProfileInfo(model.User user) {
    if (mounted){
      setState(() {
        this.user = user;
      });
    }
  }
}
