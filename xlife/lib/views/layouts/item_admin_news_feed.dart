import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/styles.dart';
import '../screens/organizer/screen_organizer_post_comments.dart';
import '../screens/organizer/screen_organizer_post_reactions.dart';

class ItemAdminNewsFeed extends StatefulWidget {
  const ItemAdminNewsFeed({Key? key}) : super(key: key);

  @override
  _ItemAdminNewsFeedState createState() => _ItemAdminNewsFeedState();
}

class _ItemAdminNewsFeedState extends State<ItemAdminNewsFeed> {
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
                            "https://hireme.ga/images/mubashar.png"))),
              ),
              title: Text(
                "Mubashar Hussain",
                style: normal_h3Style_bold,
              ),
              subtitle: Text("1 h"),
              trailing: IconButton(
                onPressed: (){
                  Get.defaultDialog(
                    title: "Delete Post",
                    middleText: "Are you sure to delete this post?",
                    onConfirm: (){},
                    onCancel: (){},
                    textConfirm: "Yes",
                    textCancel: "No"
                  );
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "post text will be here",
              style: normal_h3Style,
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
                    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg"),
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
                    "273 Reactions",
                    style:
                    normal_h3Style.copyWith(color: Colors.grey),
                  ),
                  onTap: (){
                    Get.to(ScreenOrganizerPostReactions());
                  },
                ),
                GestureDetector(
                  child: Text(
                    "97 Comments",
                    style: normal_h3Style.copyWith(color: Colors.grey),
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
