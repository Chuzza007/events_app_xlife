import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/layouts/item_user_event.dart';
import 'package:xlife/views/screens/user/screen_user_event_details.dart';
import 'package:xlife/widgets/custom_card_swiper.dart';

class LayoutUserAllEvents extends StatefulWidget {
  const LayoutUserAllEvents({Key? key}) : super(key: key);

  @override
  _LayoutUserAllEventsState createState() =>
      _LayoutUserAllEventsState();
}

class _LayoutUserAllEventsState extends State<LayoutUserAllEvents> {
  CardController cardController = CardController();
  int selectedIndex = 0;
  List<ItemUserEvent> events = [
    ItemUserEvent(),
    ItemUserEvent(),
    ItemUserEvent(),
    ItemUserEvent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.7,
        alignment: Alignment.center,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return events[index];
          },
          index: selectedIndex,
          onIndexChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          onTap: (index){
            Get.to(const ScreenUserEventDetails());
          },
          itemHeight: Get.height * 0.7,
          itemWidth: Get.width * 0.9,
          itemCount: events.length,
          containerHeight: Get.height * 0.8,
          layout: SwiperLayout.TINDER,
        ));
  }
}
