import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/layout_user_inbox.dart';
import 'package:xlife/views/layouts/layout_user_suggestions.dart';
import 'package:xlife/widgets/custom_tab_bar_view.dart';

class ScreenUserConnections extends StatefulWidget {
  const ScreenUserConnections({Key? key}) : super(key: key);

  @override
  State<ScreenUserConnections> createState() =>
      _ScreenUserConnectionsState();
}

class _ScreenUserConnectionsState extends State<ScreenUserConnections>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Connections"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: CustomTabBarView(
              tabs_length: 2,
              tabs_titles_list: ["Inbox", "Suggestions"],
              tabController: TabController(length: 2, vsync: this),
              borderRadius: BorderRadius.circular(20),
              tab_children_layouts: [
                LayoutUserInbox(),
                LayoutUserSuggestions()
              ]),
        ));
  }
}
