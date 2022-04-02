import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class CustomHeaderContainerDesign extends StatefulWidget {
  Widget child;
  Widget? bottomNavigationBar;
  Widget? title;
  bool showBack;

  @override
  _CustomHeaderContainerDesignState createState() =>
      _CustomHeaderContainerDesignState();

  CustomHeaderContainerDesign({
    required this.child,
    this.bottomNavigationBar,
    this.title,
    required this.showBack,
  });
}

class _CustomHeaderContainerDesignState
    extends State<CustomHeaderContainerDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.35,
            ),
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: []),
                ),
                Positioned(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            resizeToAvoidBottomInset: false,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              centerTitle: true,
                              title: widget.title,
                              elevation: 0,
                              titleSpacing: 0,
                              titleTextStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              automaticallyImplyLeading: false,
                              // remove back button in appbar.
                              leading: widget.showBack
                                  ? IconButton(
                                      tooltip: "Back",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back_outlined),
                                    )
                                  : null,
                            ),
                            body: Container(
                              child: widget.child,
                            ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
