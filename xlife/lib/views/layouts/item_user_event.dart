import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/styles.dart';

class ItemUserEvent extends StatefulWidget {
  @override
  State<ItemUserEvent> createState() => _ItemUserEventState();
}

class _ItemUserEventState extends State<ItemUserEvent> {
  double cardHeight = Get.height * 0.6;

  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
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
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 2.sp,
                  ),
                  Text(
                    "22 Km",
                    style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold).copyWith(
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    )),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      "2 days left",
                      style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold).copyWith(
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                height: cardHeight * 0.35,
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Event Title",
                      style: (GetPlatform.isWeb ? heading2_style_web : heading2_style).copyWith(
                          color: Colors.white),
                    ),
                    ListTile(
                      title: Text(
                        "This is the event description This is the event description This is the event description This is the event description This is the event description This is the event description ",
                        style: (GetPlatform.isWeb ? normal_h2Style_web : normal_h2Style).copyWith(
                            color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "Organized by #####",
                        style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold).copyWith(
                            color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        icon: ImageIcon(
                          AssetImage(
                              "assets/images/heart_$favorite.png"),
                          color: Colors.white,
                          size: cardHeight * 0.06,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
