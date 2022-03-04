
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../helpers/constants.dart';
import '../helpers/styles.dart';

class CustomHomeHeaderContainerDesign extends StatefulWidget {
  Widget child;
  Widget? bottomNavigationBar;
  Widget? title;
  Color? headerColor;
  Color? bodyColor;

  @override
  _CustomHomeHeaderContainerDesignState createState() =>
      _CustomHomeHeaderContainerDesignState();

  CustomHomeHeaderContainerDesign({
    required this.child,
    this.bottomNavigationBar,
    this.title,
    this.headerColor,
    this.bodyColor
  });
}

class _CustomHomeHeaderContainerDesignState
    extends State<CustomHomeHeaderContainerDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.headerColor ?? appPrimaryColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      GestureDetector(
                        onTap: (){
                        },
                        child: Hero(
                          tag: "about",
                          child: Container(

                            height: MediaQuery.of(context).size.height * 0.045,
                            width: MediaQuery.of(context).size.height * 0.045,
                            decoration: BoxDecoration(
                              color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2.sp, color: Colors.white),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://hireme.ga/images/mubashar.png"))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.sp),
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26.sp),
                          topRight: Radius.circular(26.sp),
                        ),
                        boxShadow: []),
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: widget.bodyColor ?? Color(0xFFFAFBFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26.sp),
                          topRight: Radius.circular(26.sp),
                        ),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: widget.child),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
