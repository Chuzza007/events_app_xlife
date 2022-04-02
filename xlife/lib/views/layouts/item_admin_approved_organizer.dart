import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/styles.dart';

class ItemAdminApprovedOrganizer extends StatelessWidget {
  const ItemAdminApprovedOrganizer({Key? key}) : super(key: key);

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
      child: Column(
        children: [
          ListTile(
            leading: Container(
              height: 10.h,
              width: 15.w,
              decoration: const BoxDecoration(
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
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.event, color: Colors.grey,),
                    SizedBox(width: Get.width * 0.02,),
                    const Text("Organized 10 events"),
                  ],
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Icon(Icons.dynamic_feed_sharp, color: Colors.grey,),
                //     SizedBox(width: Get.width * 0.02,),
                //     Text("15 Posts"),
                //   ],
                // ),
              ],
            ),
          ),
          ListTile(
            title: Text("Approved", style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold).copyWith(
              color: Colors.green
            ),),
            // trailing: IconButton(
            //   icon: Icon(Icons.block),
            //   onPressed: (){},
            // ),
            leading: const Icon(Icons.check_circle_rounded, color: Colors.green,),
          ),
        ],
      ),
    );
  }
}
