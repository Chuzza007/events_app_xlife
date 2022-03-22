import 'package:flutter/material.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/views/layouts/item_user_suggestion.dart';

import '../../../widgets/custom_listview_builder.dart';
import '../../layouts/item_user_inbox.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                child: Text("Suggestions", style: normal_h2Style_bold.copyWith(
                  color: appPrimaryColor
                ),),
              ),
              CustomListviewBuilder(itemBuilder: (_, index){
                return ItemUserSuggestion();
              },
                  itemCount: 15,
                  scrollDirection: CustomDirection.horizontal),

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15.0, bottom: 10),
                child: Text("Messages", style: normal_h2Style_bold.copyWith(
                    color: appPrimaryColor
                ),),
              ),
              CustomListviewBuilder(
                  itemBuilder: (_, index) {
                    return ItemUserInbox();
                  },
                  itemCount: 10,
                  scrollDirection: CustomDirection.vertical)
            ],
          ),
        ),
      ),
    );
  }
}
