import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/screens/admin/screen_admin_add_organizer.dart';
import 'package:xlife/widgets/not_found.dart';

import '../../../models/user.dart';
import '../../layouts/item_admin_approved_organizer.dart';

class ScreenAdminAllOrganizers extends StatefulWidget {
  const ScreenAdminAllOrganizers({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllOrganizersState createState() => _ScreenAdminAllOrganizersState();
}

class _ScreenAdminAllOrganizersState extends State<ScreenAdminAllOrganizers> with TickerProviderStateMixin {

  late Stream<QuerySnapshot> organizersStream;



  @override
  void initState() {
    organizersStream = organizersRef.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Organizers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ScreenAdminAddOrganizer());
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: organizersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return NotFound(
              message: "No Internet Connection",
              assetImage: "assets/images/nothing.png",
            );
          }
          var docs = snapshot.data!.docs;
          return docs.length > 0
              ? ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    var data = docs[index].data();
                    var organizer = User.fromMap(data as Map<String, dynamic>);
                    return ItemAdminApprovedOrganizer(organizer: organizer);
                  })
              : NotFound(message: "No data");
        },
      ),
    );
  }

  void update(){

  }
}
