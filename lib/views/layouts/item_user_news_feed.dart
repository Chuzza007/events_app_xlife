import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_post_details.dart';
import 'package:xlife/models/comment.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/models/reaction.dart' as model;
import 'package:xlife/models/user.dart' as userModel;
import 'package:xlife/views/screens/organizer/screen_organizer_post_reactions.dart';
import 'package:xlife/views/screens/user/screen_user_post_comments.dart';

import '../../helpers/styles.dart';
import '../screens/screen_full_image.dart';

class ItemUserNewsFeed extends StatefulWidget {
  Post post;

  @override
  State<ItemUserNewsFeed> createState() => _ItemUserNewsFeedState();

  ItemUserNewsFeed({
    required this.post,
  });
}

class _ItemUserNewsFeedState extends State<ItemUserNewsFeed> implements ListenerPostDetails {
  late List<Reaction<String>> reactions;
  String? currentReaction = null;
  int numReactions = 0, numComments = 0;
  int timestamp = 0;
  userModel.User postUser = userModel.User(
      full_name: "User Name",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      image_url: null,
      notificationToken: "",
      last_seen: 0);

  var uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    timestamp = widget.post.timestamp;
    getPostDetails(widget.post, this);
    reactions = [
      Reaction(
          title: _buildReactionTitle("None"),
          previewIcon: Icon(Icons.thumb_up_alt_outlined),
          icon: _buildIcon(Icons.thumb_up_alt_outlined, "None"),
          value: "none"),
      Reaction(title: _buildReactionTitle("Like"), previewIcon: Icon(Icons.thumb_up), icon: _buildIcon(Icons.thumb_up, "Like"), value: "like"),
      Reaction(title: _buildReactionTitle("Love"), previewIcon: Icon(Icons.favorite), icon: _buildIcon(Icons.favorite, "Love"), value: "love"),
      Reaction(
          title: _buildReactionTitle("Dislike"),
          previewIcon: Icon(Icons.thumb_down),
          icon: _buildIcon(Icons.thumb_down, "Dislike"),
          value: "dislike"),
    ];

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
                    color: Colors.black, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(postUser.image_url ?? userPlaceholder))),
              ),
              title: Text(
                postUser.full_name,
                style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
              ),
              subtitle: Text(convertTimeToText(timestamp, "ago")),
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
          GestureDetector(
            child: Container(
              height: 20.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.post.image),
                ),
              ),
            ),
            onTap: () {
              Get.to(ScreenFullImage(
                image_url: widget.post.image,
              ));
            },
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    "$numReactions Reactions",
                    style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.grey),
                  ),
                  onTap: (){
                    Get.to(ScreenOrganizerPostReactions(post: widget.post,));
                  },
                ),
                Text(
                  "$numComments Comments",
                  style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReactionButton(
                  onReactionChanged: (String? value) {
                    updateReaction(value.toString());
                  },
                  reactions: reactions,
                  boxPosition: Position.BOTTOM,
                  boxElevation: 10,
                  boxPadding: EdgeInsets.all(10),
                  boxDuration: Duration(milliseconds: 500),
                  itemScaleDuration: Duration(milliseconds: 200),
                  initialReaction: getReaction(currentReaction),
                ),
                InkWell(
                  onTap: () {
                    Get.to(ScreenUserPostComments(post: widget.post));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.comment),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Text(
                        "Comment",
                        style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionTitle(String title) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: appPrimaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        title,
        style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, String title) {
    return Row(
      children: [
        Icon(
          iconData,
          color: appPrimaryColor,
        ),
        SizedBox(
          width: 5.sp,
        ),
        Text(
          title,
          style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: appPrimaryColor),
        )
      ],
    );
  }

  Reaction<String>? getReaction(String? value) {
    Reaction<String>? reaction = null;
    reactions.forEach((element) {
      if (element.value == value) {
        reaction = element;
      }
    });
    return reaction;
  }

  @override
  void onComments(List<Comment> comments) {
    if (mounted) {
      setState(() {
        this.numComments = comments.length;
      });
    }
  }

  @override
  void onMyReaction(String? reaction) {
    if (mounted) {
      setState(() {
        this.currentReaction = reaction;
      });
    }
  }

  @override
  void onReactions(List<model.Reaction> reactions) {
    if (mounted) {
      setState(() {
        this.numReactions = reactions.length;
      });
    }
  }

  @override
  void onUserListener(userModel.User user) {
    if (mounted) {
      setState(() {
        postUser = user;
        print(user.toMap());
      });
    }
  }

  void updateReaction(String value) {
    if (value == "none") {
      postsRef.doc(widget.post.id).collection("reactions").doc(uid).delete();
      return;
    }
    postsRef
        .doc(widget.post.id)
        .collection("reactions")
        .doc(uid)
        .set(model.Reaction(user_id: uid, timestamp: DateTime.now().millisecondsSinceEpoch, value: value).toMap());
  }
}
