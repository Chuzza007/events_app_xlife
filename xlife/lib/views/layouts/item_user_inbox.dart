import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/models/message_dummy.dart';
import 'package:xlife/models/user.dart';
import 'package:xlife/views/screens/user/screen_user_chat.dart';
import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../interfaces/listener_profile_info.dart';

class ItemUserInbox extends StatefulWidget {

  MessageDummy messageDummy;


  @override
  _ItemUserInboxState createState() => _ItemUserInboxState();

  ItemUserInbox({
    required this.messageDummy,
  });
}

class _ItemUserInboxState extends State<ItemUserInbox> implements ListenerProfileInfo {

  @override
  void initState() {
    getProfileInfo(widget.messageDummy.receiver_id, this, "user");
    super.initState();
  }

  User user = User(full_name: "Unknown",
      nick_name: 'nick_name',
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");
  bool online = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(
                user.full_name,
                style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
              ),
              subtitle: Text(
                widget.messageDummy.last_message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              leading: Badge(
                badgeContent: Text(
                  "  ",
                  style: (GetPlatform.isWeb ? normal_h6Style_web : normal_h6Style).copyWith(color: Colors.white),
                ),
                badgeColor: Colors.green,
                elevation: 0,
                toAnimate: false,
                showBadge: online,
                animationDuration: Duration(seconds: 1),
                animationType: BadgeAnimationType.fade,
                position: BadgePosition.bottomEnd(
                  bottom: 5,
                  end: 0,
                ),
                child: Container(
                  height: Get.height * 0.08,
                  width: Get.width * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          user.image_url ?? userPlaceholder),
                    ),
                  ),
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(convertTimeToText(widget.messageDummy.timestamp, ""), style: TextStyle(color: hintColor),),
                  Badge(
                    badgeContent: Text(
                      " 1 ",
                      style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style).copyWith(color: Colors.white),
                    ),
                    toAnimate: false,
                    shape: BadgeShape.circle,
                    position: BadgePosition.center(),
                  ),
                ],
              ),
              onTap: () {
                Get.to(ScreenUserChat(mReceiver: user,));
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
      ),
    );
  }

  @override
  void onProfileInfo(User user) {
    if (mounted){
      setState(() {
        this.user = user;
        online = getLastSeen(user.last_seen) == "Online";
      });
    }
  }
}
