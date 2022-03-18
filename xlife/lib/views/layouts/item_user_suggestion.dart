import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../screens/user/screen_user_chat.dart';

class ItemUserSuggestion extends StatelessWidget {
  const ItemUserSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Julia H.",
              style: normal_h2Style_bold,
            ),
            leading: Container(
              height: Get.height * 0.1,
              width: Get.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://deadline.com/wp-content/uploads/2020/09/Gugu-Mbatha-Raw-e1610021013129.jpg"),
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on),
                Text(
                  "2 km",
                  style: TextStyle(color: hintColor),
                ),
              ],
            ),
            onTap: () {
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
