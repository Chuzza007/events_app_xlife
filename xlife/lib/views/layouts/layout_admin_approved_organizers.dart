import 'package:flutter/material.dart';

import 'item_admin_approved_organizer.dart';

class LayoutAdminApprovedOrganizers extends StatefulWidget {
  const LayoutAdminApprovedOrganizers({Key? key}) : super(key: key);

  @override
  _LayoutAdminApprovedOrganizersState createState() =>
      _LayoutAdminApprovedOrganizersState();
}

class _LayoutAdminApprovedOrganizersState
    extends State<LayoutAdminApprovedOrganizers> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index){
          return ItemAdminApprovedOrganizer();
        });
  }
}
