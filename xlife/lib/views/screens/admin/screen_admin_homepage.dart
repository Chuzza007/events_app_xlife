import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/admin/screen_admin_all_events.dart';
import 'package:xlife/views/screens/admin/screen_admin_all_organizers.dart';
import 'package:xlife/widgets/custom_button.dart';

class ScreenAdminHomepage extends StatefulWidget {
  const ScreenAdminHomepage({Key? key}) : super(key: key);

  @override
  _ScreenAdminHomepageState createState() =>
      _ScreenAdminHomepageState();
}

class _ScreenAdminHomepageState extends State<ScreenAdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Portal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(text: "All Events", onPressed: (){
              Get.to(ScreenAdminAllEvents());
            }),
            CustomButton(text: "Organizers", onPressed: (){
              Get.to(ScreenAdminAllOrganizers());
            }),
            CustomButton(text: "Posts", onPressed: (){}),
          ],
        ),
      ),
    );
  }
}
