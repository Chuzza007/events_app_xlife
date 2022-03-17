import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_admin_pending_organizer.dart';

import 'item_admin_approved_organizer.dart';

class LayoutAdminPendingOrganizers extends StatefulWidget {
  const LayoutAdminPendingOrganizers({Key? key}) : super(key: key);

  @override
  _LayoutAdminPendingOrganizersState createState() =>
      _LayoutAdminPendingOrganizersState();
}

class _LayoutAdminPendingOrganizersState
    extends State<LayoutAdminPendingOrganizers> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 12,
        itemBuilder: (_, index){
          return ItemAdminPendingOrganizer();
        });
  }
}
