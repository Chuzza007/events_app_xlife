import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/comment.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/models/reaction.dart';
import 'package:xlife/models/user.dart';
import 'package:xlife/views/screens/user/screen_user_post_comments.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../interfaces/listener_post_details.dart';
import '../screens/organizer/screen_organizer_post_comments.dart';
import '../screens/organizer/screen_organizer_post_reactions.dart';

class ItemAdminNewsFeed extends StatefulWidget {

  Post post;


  @override
  _ItemAdminNewsFeedState createState() => _ItemAdminNewsFeedState();

  ItemAdminNewsFeed({
    required this.post,
  });
}

class _ItemAdminNewsFeedState extends State<ItemAdminNewsFeed> implements ListenerPostDetails {

  User user = User(full_name: "Loading",
      nick_name: "",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");
  int reactions = 0;
  int comments = 0;

  @override
  void initState() {
    getPostDetails(widget.post, this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        boxShadow: appBoxShadow,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
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
              subtitle: Text(convertTimeToText(widget.post.timestamp, "ago")),
              trailing: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Delete Post",
                      middleText: "Are you sure to delete this post?",
                      onConfirm: () async {
                        Get.back();
                        postsRef.doc(widget.post.id).delete().then((value) {

                        }).catchError((error){
                          Get.snackbar("Error", error.toString());
                        });
                      },
                      onCancel: () {
                      },
                      textConfirm: "Yes",
                      textCancel: "No"
                  );
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.post.title,
              style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    widget.post.image),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    "$reactions Reactions",
                    style:
                    (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.grey),
                  ),
                  onTap: () {
                    Get.to(ScreenOrganizerPostReactions(post: widget.post,));
                  },
                ),
                GestureDetector(
                  child: Text(
                    "$comments Comments",
                    style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.grey),
                  ),
                  onTap: () {
                    Get.to(ScreenUserPostComments(post: widget.post));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onComments(List<Comment> comments) {
    if (mounted){
      setState(() {
        this.comments = comments.length;
      });
    }
  }

  @override
  void onMyReaction(String? reaction) {
    // TODO: implement onMyReaction
  }

  @override
  void onReactions(List<Reaction> reactions) {
    if (mounted){
      setState(() {
        this.reactions = reactions.length;
      });
    }
  }

  @override
  void onUserListener(User user) {
    if (mounted){
      setState(() {
        this.user = user;
      });
    }
  }
}
