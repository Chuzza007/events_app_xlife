import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:xlife/interfaces/listener_events.dart';
import 'package:xlife/interfaces/listener_post_details.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/models/reaction.dart';
import 'package:xlife/models/user.dart' as model;

import '../generated/locales.g.dart';
import '../interfaces/listener_organizer_events_posts.dart';
import '../models/comment.dart';
import '../widgets/custom_button.dart';

MaterialColor appPrimaryColor = MaterialColor(
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
Color hintColor = Color(0xFFA0A2A8);
Color buttonColor = Color(0xFFF13B2D);
List<String> allEventTags = [];
Position? currentPosition;
String googleAPIKey = "AIzaSyB2tfPVP5CVeqDZAtuMjzE_tz0K62Gb_LY";
CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
CollectionReference organizersRef = FirebaseFirestore.instance.collection("organizers");
CollectionReference eventsRef = FirebaseFirestore.instance.collection("events");
CollectionReference postsRef = FirebaseFirestore.instance.collection("posts");
String userPlaceholder = "https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png";

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Align(alignment: Alignment.centerLeft, child: title),
                ),
                Container(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
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
                    margin: EdgeInsets.symmetric(horizontal: 10),
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

void showModalBottomSheetMenu({required BuildContext context, required Widget content, double? height}) {
  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (context) {
        return SafeArea(
            child:
                Container(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), child: SingleChildScrollView(child: content)));
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

Future<DateTime> selectDate(BuildContext context, int startTimestamp, int? selectedTimestamp) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(selectedTimestamp ?? startTimestamp),
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

Future<void> getOrganizerEventsPosts(String id, ListenerOrganizerEventsPosts listener) async {
  eventsRef.where("organizer_id", isEqualTo: id).snapshots().listen((event) {
    List<Event> events = [];
    var docs = event.docs;
    events = docs.map((e) => Event.fromMap(e.data() as Map<String, dynamic>)).toList();
    listener.onEventsInfo(events);
  });

  postsRef.where("user_id", isEqualTo: id).snapshots().listen((event) {
    List<Post> posts = [];
    var docs = event.docs;
    posts = docs.map((e) => Post.fromMap(e.data() as Map<String, dynamic>)).toList();
    listener.onPostsInfo(posts);
  });
}

Future<void> getProfileInfo(String id, ListenerProfileInfo listener, String profileType) async {
  await FirebaseFirestore.instance.collection("${profileType}s").where("id", isEqualTo: id).snapshots().listen((event) {

    // print(event.docs);

    if (event.docs.length > 0){
      var data = event.docs[0].data();
      // print(data);
      model.User user = model.User.fromMap(data);
      listener.onProfileInfo(user);
    }
  });
}

void getPostDetails(Post post, ListenerPostDetails listener) async {

  String uid = FirebaseAuth.instance.currentUser!.uid;

  postsRef.doc(post.id).collection("comments").snapshots().listen((event) {
    List<Comment> comments = [];
    comments = event.docs.map((e) => Comment.fromMap(e.data())).toList();
    listener.onComments(comments);
  });
  postsRef.doc(post.id).collection("reactions").snapshots().listen((event) {
    List<Reaction> reactions = [];
    listener.onMyReaction(null);
    reactions = event.docs.map((e) => Reaction.fromMap(e.data())).toList();
    listener.onReactions(reactions);
    reactions.forEach((element) {
      if (element.user_id == uid){
        listener.onMyReaction(element.value);
      }
    });
  });
  FirebaseFirestore.instance.collection("${post.userType}s").doc(post.user_id).snapshots().listen((event) {
    listener.onUserListener(model.User.fromMap(event.data() as Map<String, dynamic>));
  });
}

void getAllEvents(ListenerEvents listenerEvents){
  eventsRef.snapshots().listen((event) {
    List<Event> events = [];
    if (event.docs.isNotEmpty){
      events = event.docs.map((e) => Event.fromMap(e.data() as Map<String, dynamic>)).toList();
    }
    listenerEvents.onEventAdded(events);
  });
}

String convertTimeToText2(
    String prefix, int timestamp, String suffix) {
  String convTime = "";

  try {
    DateTime dateTime1 =
    DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);

    int second = dateTime1.difference(dateTime2).inSeconds;
    int minute = dateTime1.difference(dateTime2).inMinutes;
    int hour = dateTime1.difference(dateTime2).inHours;
    int day = dateTime1.difference(dateTime2).inDays;

    if (second < 60) {
      convTime = "$prefix ${second} secs $suffix";
    } else if (minute < 60) {
      convTime = "$prefix ${minute} mins $suffix";
    } else if (hour < 24) {
      convTime = "$prefix ${hour} hrs $suffix";
    } else if (day >= 7) {
      if (day > 360) {
        convTime = "$prefix ${day ~/ 360} yrs $suffix";
      } else if (day > 30) {
        convTime = "$prefix ${day ~/ 30} mons $suffix";
      } else {
        convTime = "$prefix ${day ~/ 7} weeks $suffix";
      }
    } else if (day < 7) {
      convTime = "$prefix ${day} days $suffix";
    }
  } catch (e) {
    print(e.toString() + "------");
  }

  return convTime;
}
void fetchAllTags(){
  eventsRef.snapshots().listen((response) {
    response.docs.forEach((element) {
      allEventTags.addAll(Event.fromMap(element.data() as Map<String, dynamic>).tags.map((e) => e.toString().trim()));
    });
    allEventTags = allEventTags.toSet().toList();
    print (allEventTags);
  });
}
double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}