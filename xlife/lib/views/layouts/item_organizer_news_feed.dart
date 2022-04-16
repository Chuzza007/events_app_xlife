import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_post_comments.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_post_reactions.dart';
import 'package:xlife/views/screens/screen_full_image.dart';

import '../../helpers/styles.dart';

class ItemOrganizerNewsFeed extends StatefulWidget {

  Post post;

  @override
  _ItemOrganizerNewsFeedState createState() =>
      _ItemOrganizerNewsFeedState();

  ItemOrganizerNewsFeed({
    required this.post,
  });
}

class _ItemOrganizerNewsFeedState
    extends State<ItemOrganizerNewsFeed> {
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
                            widget.post.image))),
              ),
              title: Text(
                "Organizer",
                style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
              ),
              subtitle: Text(convertTimeToText(widget.post.timestamp, "")),
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
                  image: NetworkImage(
                      widget.post.image),
                ),
              ),
            ),
            onTap: (){
              Get.to(ScreenFullImage(image_url: widget.post.image));
            },
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    "273 Reactions",
                    style:
                        (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.grey),
                  ),
                  onTap: (){
                    Get.to(ScreenOrganizerPostReactions(post: widget.post,));
                  },
                ),
                GestureDetector(
                  child: Text(
                    "97 Comments",
                    style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.grey),
                  ),
                  onTap: (){
                    Get.to(ScreenOrganizerPostComments());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
