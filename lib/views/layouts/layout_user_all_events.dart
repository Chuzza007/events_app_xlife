import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_events.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/views/layouts/item_user_event.dart';
import 'package:xlife/widgets/custom_card_swiper.dart';
import 'package:xlife/widgets/custom_listview_builder.dart';
import 'package:xlife/widgets/not_found.dart';

class LayoutUserAllEvents extends StatefulWidget {

  @override
  _LayoutUserAllEventsState createState() => _LayoutUserAllEventsState();

}

class _LayoutUserAllEventsState extends State<LayoutUserAllEvents> implements ListenerEvents {
  CardController cardController = CardController();
  int selectedIndex = 0;
  List<Event> events = [];
  String selectedType = "all";
  List<String> allEventsTypes = ["all", "dance", "drink", "eat", "find", "travel"];
  List<String> allEventsTitles = ["See All", "Dance", "Have a drink", "Eat", "Find an activity", "Traveling"];

  bool loading = true;

  @override
  void initState() {
    getAllEvents(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: events.isNotEmpty ? Container(
          height: Get.height * 0.9,
          width: Get.width,
          alignment: Alignment.center,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ItemUserEvent(event: events[index]);
            },
            index: selectedIndex,
            onIndexChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemHeight: Get.height * 0.9,
            itemWidth: Get.width,
            itemCount: events.length,
            containerHeight: Get.height * 0.8,
            layout: SwiperLayout.TINDER,
          )) : NotFound(message: LocaleKeys.NoEventsFound.tr),
      secondChild: Center(child: CupertinoActivityIndicator()),
      duration: Duration(seconds: 1),
    );
  }

  @override
  void onEventAdded(List<Event> events) {
    if (mounted) {
      showDefaultDialog();
      setState(() {
        this.loading = false;
        this.events = events;
      });
    }
  }

  void showDefaultDialog() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      contentPadding: EdgeInsets.all(10),
      title: LocaleKeys.WhatToDoToday.tr,
      content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return CustomListviewBuilder(
          itemBuilder: (context, index){
            return RadioListTile(
                title: Text(allEventsTitles[index]),
                value: allEventsTypes[index], groupValue: selectedType, onChanged: (value){
              setState((){
                selectedType = value.toString();
              });
            });
          },
          itemCount: allEventsTypes.length,
          scrollDirection: CustomDirection.vertical,
        );
      }),
      onConfirm: (){
        Get.back();

        setState(() {
          if (selectedType != "all"){
            events = events.where((element) => element.tags.contains(selectedType)).toList();
          }
        });
      },
      textConfirm: LocaleKeys.Select.tr
    );
  }
}
