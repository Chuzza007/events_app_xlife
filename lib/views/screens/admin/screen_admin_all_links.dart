import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_admin_links.dart';
import 'layout_links.dart';

class ScreenAdminAllLinks extends StatefulWidget {
  const ScreenAdminAllLinks({Key? key}) : super(key: key);

  @override
  _ScreenAdminAllLinksState createState() => _ScreenAdminAllLinksState();
}

class _ScreenAdminAllLinksState extends State<ScreenAdminAllLinks> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Links"),
      ),
      body: LinksLayout(),
    );
  }
}
