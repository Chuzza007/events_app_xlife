
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants.dart';
import '../helpers/styles.dart';

class CustomButton extends StatefulWidget {
  Color? color;
  String text;
  double? width;
  double? height;
  VoidCallback onPressed;

  CustomButton(
      {this.color,
      required this.text,
      required this.onPressed,
      this.width,
      this.height});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: widget.height ?? Get.height * .07,
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            primary: widget.color ?? buttonColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          ),
          child: Text(
            widget.text,
            style: (GetPlatform.isWeb ? normal_h2Style_web : normal_h2Style).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
