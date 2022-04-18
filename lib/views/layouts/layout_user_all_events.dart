import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_events.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/views/layouts/item_user_event.dart';
import 'package:xlife/views/screens/user/screen_user_event_details.dart';
import 'package:xlife/widgets/custom_card_swiper.dart';
import 'package:xlife/widgets/custom_progress_widget.dart';

class LayoutUserAllEvents extends StatefulWidget {
  LayoutUserAllEvents({Key? key}) : super(key: key);

  @override
  _LayoutUserAllEventsState createState() => _LayoutUserAllEventsState();
}

class _LayoutUserAllEventsState extends State<LayoutUserAllEvents> implements ListenerEvents {
  CardController cardController = CardController();
  int selectedIndex = 0;
  List<Event> events = [];

  bool loading = true;
  @override
  void initState() {
    getAllEvents(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomProgressWidget(
      loading: loading,
      child: Container(
          height: Get.height * 0.7,
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
            itemHeight: Get.height * 0.7,
            itemWidth: Get.width * 0.9,
            itemCount: events.length,
            containerHeight: Get.height * 0.8,
            layout: SwiperLayout.TINDER,
          )),
    );
  }

  @override
  void onEventAdded(List<Event> events) {
    if (mounted){
      setState(() {
        this.loading = false;
        this.events = events;
      });
    }
  }
}
