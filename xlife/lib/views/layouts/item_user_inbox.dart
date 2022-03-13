import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/user/screen_user_chat.dart';
import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class ItemUserrInbox extends StatefulWidget {
  const ItemUserrInbox({Key? key}) : super(key: key);

  @override
  _ItemUserrInboxState createState() => _ItemUserrInboxState();
}

class _ItemUserrInboxState extends State<ItemUserrInbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Sami Khan",
              style: normal_h2Style_bold,
            ),
            subtitle: Text(
              "hey john,\n I’m looking for a video editor for my video editing task.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Badge(
              badgeContent: Text(
                "1",
                style: normal_h6Style.copyWith(color: Colors.white),
              ),
              badgeColor: Colors.orange,
              elevation: 0,
              animationDuration: Duration(seconds: 1),
              animationType: BadgeAnimationType.fade,
              position: BadgePosition.bottomEnd(
                bottom: 5,
                end: 0,
              ),
              child: Container(
                height: Get.height * 0.1,
                width: Get.width * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/3/3a/Elton_John_Cannes_2019.jpg"),
                  ),
                ),
              ),
            ),
            trailing: Text("3 hr", style: TextStyle(color: hintColor),),
            onTap: (){
              Get.to(ScreenUserChat());
            },
          ),
          Divider(
            color: Colors.black45,
            indent: Get.width * 0.1,
            endIndent: Get.width * 0.05,
            height: Get.height * 0.03,
          )
        ],
      ),
    );
  }
}
