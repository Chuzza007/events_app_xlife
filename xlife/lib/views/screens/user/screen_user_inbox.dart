import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_user_inbox.dart';

class ScreenUserInbox extends StatelessWidget {
  const ScreenUserInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) {
          return ItemUserrInbox();
        },
      ),
    );
  }
}
