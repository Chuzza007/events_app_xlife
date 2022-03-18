import 'package:flutter/material.dart';

import 'item_user_inbox.dart';

class LayoutUserInbox extends StatefulWidget {
  const LayoutUserInbox({Key? key}) : super(key: key);

  @override
  _LayoutUserInboxState createState() => _LayoutUserInboxState();
}

class _LayoutUserInboxState extends State<LayoutUserInbox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) {
        return ItemUserrInbox();
      },
    );
  }
}
