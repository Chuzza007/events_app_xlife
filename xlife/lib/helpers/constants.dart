import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../generated/locales.g.dart';
import '../widgets/custom_button.dart';

MaterialColor appPrimaryColor = const MaterialColor(
  0xFFA033FF,
  <int, Color>{
    50: Color(0xFFA033FF),
    100: Color(0xFFA033FF),
    200: Color(0xFFA033FF),
    300: Color(0xFFA033FF),
    400: Color(0xFFA033FF),
    500: Color(0xFFA033FF),
    600: Color(0xFFA033FF),
    700: Color(0xFFA033FF),
    800: Color(0xFFA033FF),
    900: Color(0xFFA033FF),
  },
);
String appName = LocaleKeys.AppName.tr;
Color hintColor = const Color(0xFFA0A2A8);
Color buttonColor = const Color(0xFFF13B2D);
String googleAPIKey = "AIzaSyB2tfPVP5CVeqDZAtuMjzE_tz0K62Gb_LY";
CollectionReference usersRef =
FirebaseFirestore.instance.collection("users");
CollectionReference organizersRef =
FirebaseFirestore.instance.collection("organizers");

void showOptionsBottomSheet({
  required BuildContext context,
  required Text title,
  required List<ListTile> options,
  required ValueChanged<int> onItemSelected,
  bool? showSkipButton,
  String? skipButtonText,
  VoidCallback? onSkipPressed,
}) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10),
                  child: Align(
                      alignment: Alignment.centerLeft, child: title),
                ),
                Container(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: options.map((e) {
                        int index = options.indexOf(e);
                        return InkWell(
                            onTap: () {
                              onItemSelected(index);

                              print(index);
                            },
                            child: e);
                      }).toList(),
                    ),
                  ),
                ),
                Visibility(
                  visible: showSkipButton ?? false,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(
                        text: skipButtonText ?? "Cancel",
                        onPressed: onSkipPressed ??
                                () {
                              Navigator.of(context).pop();
                            }),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
    ) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}


Future<DateTime> selectDate(BuildContext context, int startTimestamp,
    int? selectedTimestamp) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(
          selectedTimestamp ?? startTimestamp),
      firstDate: DateTime.fromMillisecondsSinceEpoch(startTimestamp),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) selectedDate = picked;

  return selectedDate;
}


String timestampToDateFormat(int timestamp, String format) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return intl.DateFormat(format).format(dateTime);
}


void showIosDialog(
    {required BuildContext context,
      required String title,
      required String message,
      VoidCallback? onConfirm,
      VoidCallback? onCancel,
      String? confirmText,
      String? cancelText}) {
  showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text(cancelText ?? "Cancel"),
              onPressed: onCancel ??
                      () {
                    Navigator.pop(context);
                  },
              isDefaultAction: true,
            ),
            CupertinoDialogAction(
              child: Text(
                confirmText ?? "Ok",
              ),
              isDestructiveAction: true,
              onPressed: onConfirm,
            ),
          ],
        );
      });
}


String timeStampToDateTime(int timestamp, String pattern) {
  return intl.DateFormat(pattern).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String convertTimeToText(int timestamp, String suffix) {
  String convTime = "";
  String prefix = "";

  try {
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);

    int second = dateTime1.difference(dateTime2).inSeconds;
    int minute = dateTime1.difference(dateTime2).inMinutes;
    int hour = dateTime1.difference(dateTime2).inHours;
    int day = dateTime1.difference(dateTime2).inDays;

    if (second < 60) {
      convTime = "${second}s $suffix";
    } else if (minute < 60) {
      convTime = "${minute} m $suffix";
    } else if (hour < 24) {
      convTime = "${hour} h $suffix";
    } else if (day >= 7) {
      if (day > 360) {
        convTime = "${day ~/ 360} y $suffix";
      } else if (day > 30) {
        convTime = "${day ~/ 30} mon $suffix";
      } else {
        convTime = "${day ~/ 7} w $suffix";
      }
    } else if (day < 7) {
      convTime = "${day} d $suffix";
    }
  } catch (e) {
    print(e.toString() + "------");
  }

  return convTime;
}