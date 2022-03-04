import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUserEventDetails extends StatefulWidget {
  const ScreenUserEventDetails({Key? key}) : super(key: key);

  @override
  _ScreenUserEventDetailsState createState() =>
      _ScreenUserEventDetailsState();
}

class _ScreenUserEventDetailsState
    extends State<ScreenUserEventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text("Event Title"),
            expandedHeight: Get.height * 0.3,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg")
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
