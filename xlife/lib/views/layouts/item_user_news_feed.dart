import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/screens/user/screen_user_post_comments.dart';

import '../../helpers/styles.dart';

class ItemUserNewsFeed extends StatefulWidget {
  const ItemUserNewsFeed({Key? key}) : super(key: key);

  @override
  State<ItemUserNewsFeed> createState() => _ItemUserNewsFeedState();
}

class _ItemUserNewsFeedState extends State<ItemUserNewsFeed> {
  late List<Reaction<String>> reactions;

  @override
  void initState() {
    reactions = [
      Reaction(
          title: _buildReactionTitle("None"),
          previewIcon: Icon(Icons.thumb_up_alt_outlined),
          icon: _buildIcon(Icons.thumb_up_alt_outlined, "None"),
          value: "none"),
      Reaction(
          title: _buildReactionTitle("Like"),
          previewIcon: Icon(Icons.thumb_up),
          icon: _buildIcon(Icons.thumb_up, "Like"),
          value: "like"),
      Reaction(
          title: _buildReactionTitle("Love"),
          previewIcon: Icon(Icons.favorite),
          icon: _buildIcon(Icons.favorite, "Love"),
          value: "love"),
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
                Text("273 Reactions", style: normal_h3Style.copyWith(color: Colors.grey),),
                Text("97 Comments", style: normal_h3Style.copyWith(color: Colors.grey),)
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
                    print(value);
                  },
                  reactions: reactions,
                  boxPosition: Position.BOTTOM,
                  boxElevation: 10,
                  boxPadding: EdgeInsets.all(10),
                  boxDuration: Duration(milliseconds: 500),
                  itemScaleDuration:
                      const Duration(milliseconds: 200),
                ),
                InkWell(
                  onTap: (){
                    Get.to(ScreenUserPostComments());
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
                        style: normal_h3Style,
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
        style: normal_h3Style.copyWith(color: Colors.white),
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
          style: normal_h3Style.copyWith(color: appPrimaryColor),
        )
      ],
    );
  }
}
