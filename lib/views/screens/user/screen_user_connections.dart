import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/models/message_dummy.dart';
import 'package:xlife/views/layouts/item_user_suggestion.dart';
import 'package:xlife/widgets/not_found.dart';

import '../../../widgets/custom_listview_builder.dart';
import '../../layouts/item_user_inbox.dart';

class ScreenUserConnections extends StatefulWidget {
  ScreenUserConnections({Key? key}) : super(key: key);

  @override
  State<ScreenUserConnections> createState() => _ScreenUserConnectionsState();
}

class _ScreenUserConnectionsState extends State<ScreenUserConnections> with TickerProviderStateMixin {
  List<String> suggestedUsers = [];

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    getSuggestedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 10),
                child: Text(
                  "Suggestions",
                  style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold).copyWith(color: appPrimaryColor),
                ),
              ),
              suggestedUsers.isNotEmpty
                  ? CustomListviewBuilder(
                      itemBuilder: (_, index) {
                        return ItemUserSuggestion(userId: suggestedUsers[index]);
                      },
                      itemCount: suggestedUsers.length,
                      scrollDirection: CustomDirection.horizontal)
                  : Center(child: Text("No Suggestions")),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15.0, bottom: 10),
                child: Text(
                  "Messages",
                  style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold).copyWith(color: appPrimaryColor),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: usersRef.doc(uid).collection("chats").orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<MessageDummy> messageDummies =
                        snapshot.data!.docs.map((e) => MessageDummy.fromMap(e.data() as Map<String, dynamic>)).toList();

                    return messageDummies.isNotEmpty
                        ? CustomListviewBuilder(
                            itemBuilder: (_, index) {
                              return ItemUserInbox(messageDummy: messageDummies[index]);
                            },
                            itemCount: messageDummies.length,
                            scrollDirection: CustomDirection.vertical)
                        : NotFound(showImage: false, message: "No messages");
                  })
            ],
          ),
        ),
      ),
    );
  }

  void getSuggestedUsers() async {
    suggestedUsers = await getUserSuggestions();
    if (suggestedUsers.contains(uid)){
      suggestedUsers.remove(uid);
    }
    if (mounted) {
      setState(() {});
    }
  }
}
