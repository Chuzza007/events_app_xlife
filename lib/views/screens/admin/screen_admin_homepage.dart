import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/views/screens/admin/screen_admin_all_events.dart';
import 'package:xlife/views/screens/admin/screen_admin_all_links.dart';
import 'package:xlife/views/screens/admin/screen_admin_all_organizers.dart';
import 'package:xlife/views/screens/admin/screen_admin_all_posts.dart';
import 'package:xlife/widgets/custom_button.dart';

import '../../../controllers/controller_admin_links.dart';

class ScreenAdminHomepage extends StatefulWidget {
  ScreenAdminHomepage({Key? key}) : super(key: key);

  @override
  _ScreenAdminHomepageState createState() =>
      _ScreenAdminHomepageState();
}

class _ScreenAdminHomepageState extends State<ScreenAdminHomepage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.AdminPortal.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.SelectOption.tr,
              style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
            ),
            CustomButton(
                text: LocaleKeys.AllEvents.tr,
                onPressed: () {
                  Get.to(ScreenAdminAllEvents());
                }),
            CustomButton(
                text:LocaleKeys.Organizers.tr,
                onPressed: () {
                  Get.to(ScreenAdminAllOrganizers());
                }),
            CustomButton(
                text: LocaleKeys.Posts.tr,
                onPressed: () {
                  Get.to(ScreenAdminAllPosts());
                }),
            CustomButton(
                text: "Links",
                onPressed: () {
                  Get.to(ScreenAdminAllLinks());
                }),
          ],
        ),
      ),
    );
  }
}
