import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenFullImage extends StatefulWidget {
  String image_url;

  @override
  _ScreenFullImageState createState() => _ScreenFullImageState();

  ScreenFullImage({
    required this.image_url,
  });
}

class _ScreenFullImageState extends State<ScreenFullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(widget.image_url))),
            ),
            Positioned(
              left: Get.width * 0.05,
              top: Get.height * 0.03,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
