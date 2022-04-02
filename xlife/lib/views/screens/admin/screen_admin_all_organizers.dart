import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/admin/screen_admin_add_organizer.dart';

import '../../layouts/item_admin_approved_organizer.dart';

class ScreenAdminAllOrganizers extends StatefulWidget {
  const ScreenAdminAllOrganizers({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllOrganizersState createState() =>
      _ScreenAdminAllOrganizersState();
}

class _ScreenAdminAllOrganizersState
    extends State<ScreenAdminAllOrganizers>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Organizers (27)"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(const ScreenAdminAddOrganizer());
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index){
            return const ItemAdminApprovedOrganizer();
          }),
    );
  }
}
