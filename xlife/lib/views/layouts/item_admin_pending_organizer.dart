import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/widgets/custom_button.dart';

import '../../helpers/styles.dart';

class ItemAdminPendingOrganizer extends StatelessWidget {
  const ItemAdminPendingOrganizer({Key? key}) : super(key: key);

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
          ),
          ListTile(
            title: Text(
              "Pending",
              style: normal_h2Style_bold.copyWith(color: Colors.grey),
            ),
            leading: Icon(
              Icons.info,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Approve",
                  onPressed: () {},
                  height: Get.height * 0.05,
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: CustomButton(
                  text: "Reject",
                  onPressed: () {},
                  height: Get.height * 0.05,
                  color: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
