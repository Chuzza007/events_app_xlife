import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/styles.dart';

class ItemAdminEventFavorite extends StatefulWidget {
  ItemAdminEventFavorite({Key? key}) : super(key: key);

  @override
  _ItemAdminEventFavoriteState createState() =>
      _ItemAdminEventFavoriteState();
}

class _ItemAdminEventFavoriteState
    extends State<ItemAdminEventFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: appBoxShadow,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(5.sp),
      padding: EdgeInsets.all(5.sp),
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
          style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
        ),
        trailing: Text(
          "1 h",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
