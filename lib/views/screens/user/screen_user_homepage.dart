import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/helpers/fcm.dart';
import 'package:xlife/views/layouts/layout_user_all_events.dart';
import 'package:xlife/views/layouts/layout_user_favorite_events.dart';
import 'package:xlife/views/layouts/layout_user_news_feed.dart';
import 'package:xlife/views/layouts/layout_user_search_events_by_organizers.dart';
import 'package:xlife/widgets/custom_bottom_navigation.dart';
import 'package:xlife/widgets/custom_home_header_container_design.dart';

class ScreenUserHomepage extends StatefulWidget {
  ScreenUserHomepage({Key? key}) : super(key: key);

  @override
  _ScreenUserHomepageState createState() => _ScreenUserHomepageState();
}

class _ScreenUserHomepageState extends State<ScreenUserHomepage> implements ListenerProfileInfo {
  int selectedIndex = 0;
  List<Widget> pages = [];
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final location = loc.Location();
  final int NEARBY_LIMIT = 800;
  model.User user = model.User(full_name: "Username",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");

  @override
  void initState() {
    pages = [
      LayoutUserAllEvents(),
      LayoutUserSearchEventsByOrganizers(),
      LayoutUserFavoriteEvents(),
      LayoutUserNewsFeed(),
    ];
    initializeFCM();
    _checkLocationPermissions();
    getProfileInfo(uid, this, "user");
    location.enableBackgroundMode(enable: true);
    _getCurrentLocation();
    updateLastSeenAndToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomHomeHeaderContainerDesign(
        image_url: user.image_url ?? userPlaceholder,
        child: pages[selectedIndex],
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          showSelectedLabels: false,
          type: CustomBottomNavigationType.animating,
          showUnselectedLabels: false,
          selectedItemColor: appPrimaryColor,
          unselectedItemColor: Colors.black26,
          items: [
            CustomBottomMenuItem(
              label: LocaleKeys.NearbyEvents.tr,
              icon: ImageIcon(AssetImage("assets/images/multiple_events.png")),
            ),
            CustomBottomMenuItem(
              label: LocaleKeys.Search.tr,
              icon: ImageIcon(AssetImage("assets/images/search_events.png")),
            ),
            CustomBottomMenuItem(
              label: LocaleKeys.Favorites.tr,
              icon: ImageIcon(AssetImage("assets/images/star.png")),
            ),
            CustomBottomMenuItem(
              label: LocaleKeys.NewsFeed.tr,
              icon: ImageIcon(AssetImage("assets/images/newsfeed.png")),
            ),
          ],
          primaryIndex: 0,
        ),
        type: HomePageType.user,
      ),
    );
  }

  Future<void> updateLastSeenAndToken() async {
    int last_seen = DateTime
        .now()
        .millisecondsSinceEpoch;
    String? token = await FCM.generateToken();
    usersRef.doc(uid).update({"last_seen": last_seen, "notificationToken": token});
    Timer.periodic(const Duration(minutes: 4), (timer) async {
      int last_seen = DateTime
          .now()
          .millisecondsSinceEpoch;
      usersRef.doc(uid).update({"last_seen": last_seen});
    });
  }

  Future<void> _checkLocationPermissions() async {
    // var permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // Permissions are denied, next time you could try
    //     // requesting permissions again (this is also where
    //     // Android's shouldShowRequestPermissionRationale
    //     // returned true. According to Android guidelines
    //     // your App should show an explanatory UI now.
    //     return Future.error(LocaleKeys.LocationPermissionsDenied.tr);
    //   }
    //   return;
    // }
    //
    // if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
    //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //
    //   if (!serviceEnabled) {
    //     await Geolocator.openLocationSettings();
    //     _checkLocationPermissions();
    //   }
    // }

    _getCurrentLocation();

  }

  void _getCurrentLocation() async {
    var _serviceEnabled = await location.serviceEnabled();
    location.changeSettings(interval: 10000);
    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      // print(currentLocation);
      usersRef.doc(uid).update({"latitude": currentLocation.latitude, "longitude": currentLocation.longitude});
    });
    Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.low,
        )).listen((currentLocation) {
      if (mounted) {
        setState(() {
          currentPosition = currentLocation;
        });
      }
      usersRef.doc(uid).update({"latitude": currentLocation.latitude, "longitude": currentLocation.longitude});
      _addNearbyUsers();
    });
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  void _addNearbyUsers() async {
    var snaps = await usersRef.snapshots();
    snaps.forEach((element) {
      List<String> usersList = [];
      element.docs.forEach((e) {
        final user = model.User.fromMap(e.data() as Map<String, dynamic>);
        if (user.id != uid && currentPosition != null && user.latitude != null) {
          if (Geolocator.distanceBetween(currentPosition!.latitude, currentPosition!.longitude, user.latitude!, user.longitude!) <= NEARBY_LIMIT) {
            usersList.add(user.id);
          };
        }
      });
      // print(usersList);
      addUserSuggestions(usersList);
    });
  }

  initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(event);
      Get.snackbar(event.notification!.title.toString(),
          event.notification!.body.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 10));
    });
  }

  @override
  void onProfileInfo(model.User user) {
    if (mounted){
      setState(() {
        this.user = user;
      });
    }
  }
}
