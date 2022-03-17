import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/layout_admin_approved_organizers.dart';
import 'package:xlife/views/layouts/layout_admin_pending_organizers.dart';
import 'package:xlife/widgets/custom_tab_bar_view.dart';

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
        title: Text("All Organizers (27)"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: CustomTabBarView(
          tabs_length: 2,
          borderRadius: BorderRadius.circular(20),
          tabs_titles_list: ["Approved (20)", "Pending (12)"],
          tabController: TabController(length: 2, vsync: this),
          tab_children_layouts: [
            LayoutAdminApprovedOrganizers(),
            LayoutAdminPendingOrganizers()
          ],
        ),
      ),
    );
  }
}
