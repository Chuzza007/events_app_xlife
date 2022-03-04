import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/styles.dart';

class ItemUserEvent extends StatelessWidget {
  double cardHeight = Get.height * 0.6;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Colors.white,),
                  SizedBox(width: 2.sp,),
                  Text(
                    "22 Km",
                    style: normal_h1Style_bold.copyWith(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            height: cardHeight * 0.3,
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Event Title",
                  style: heading1_style.copyWith(color: Colors.white),
                ),
                ListTile(
                  title: Text(
                    "This is the event description This is the event description This is the event description This is the event description This is the event description This is the event description ",
                    style:
                        normal_h1Style.copyWith(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(
                    Icons.info,
                    size: cardHeight * 0.06,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
