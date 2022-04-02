import 'package:flutter/material.dart';
import 'package:xlife/widgets/custom_listview_builder.dart';

import 'item_user_inbox.dart';

class LayoutUserInbox extends StatefulWidget {
  const LayoutUserInbox({Key? key}) : super(key: key);

  @override
  _LayoutUserInboxState createState() => _LayoutUserInboxState();
}

class _LayoutUserInboxState extends State<LayoutUserInbox> {
  @override
  Widget build(BuildContext context) {
    return CustomListviewBuilder(
      scrollDirection: CustomDirection.vertical,
      itemCount: 20,
      itemBuilder: (_, index) {
        return const ItemUserInbox();
      },
    );
  }
}
