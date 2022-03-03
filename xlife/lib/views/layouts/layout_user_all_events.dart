import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/views/layouts/item_user_event.dart';
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
      itemHeight: Get.height * 0.6,
      itemWidth: Get.width * 0.9,
      itemCount: events.length,
      containerHeight: Get.height * 0.8,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: Colors.grey,
          activeColor: appPrimaryColor,
        ),
      ),
      layout: SwiperLayout.TINDER,
    ));
  }
}
