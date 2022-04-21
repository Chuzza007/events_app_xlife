import 'dart:async';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/interfaces/listener_event_favorites.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/models/user.dart';
import 'package:xlife/views/layouts/item_admin_event_favorite.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_update_event.dart';
import 'package:xlife/widgets/custom_chips.dart';
import 'package:xlife/widgets/not_found.dart';

class ScreenAdminEventDetails extends StatefulWidget {
  Event event;
  bool editEnabled;

  @override
  _ScreenAdminEventDetailsState createState() => _ScreenAdminEventDetailsState();

  ScreenAdminEventDetails({
    required this.event,
    required this.editEnabled,
  });
}

class _ScreenAdminEventDetailsState extends State<ScreenAdminEventDetails> implements ListenerProfileInfo, ListenerEventFavorites {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng initPosition = LatLng(0, 0); //initial Position cannot assign null values
  LatLng currentLatLng = LatLng(0.0, 0.0); //initial currentPosition values cannot assign null values
  //initial permission status
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  List<String> images = [];
  User organizer = User(
      full_name: "Unknown",
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
  int favorites = 0;
  List<String> favoriteUsers = [];

  @override
  void initState() {
    _checkLocationPermissions();
    images = [
      widget.event.image1,
      widget.event.image2,
      widget.event.image3,
    ];
    getProfileInfo(widget.event.organizer_id, this, "organizer");
    getEventFavorites(widget.event.id, this);

    setState(() {
      _kGooglePlex = CameraPosition(target: LatLng(widget.event.latitude, widget.event.longitude), zoom: 18);
    });
    super.initState();
  }

  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DraggableHome(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.event.title),
              TextButton(
                onPressed: () {
                  Get.to(ScreenOrganizerUpdateEvent(event: widget.event));
                },
                child: Text(LocaleKeys.Edit.tr),
              )
            ],
          ),
          headerWidget: Stack(
            children: [
              PageView(
                children: _buildPagesByLinks(),
                onPageChanged: (index) {
                  setState(() {
                    imageIndex = index;
                  });
                },
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.all(10.sp),
                  color: Colors.black.withOpacity(.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.event.title,
                        style: (GetPlatform.isWeb ? heading3_style_web : heading3_style).copyWith(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 1.w,
                  bottom: 5.h,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${imageIndex + 1} / ${images.length}",
                      style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold).copyWith(color: Colors.white),
                    ),
                  ))
            ],
          ),
          headerExpandedHeight: 0.55,
          stretchMaxHeight: .6,
          centerTitle: true,
          backgroundColor: Colors.white,
          body: [
            // ListTile(
            //   title: Text(
            //     "Distance",
            //     style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
            //   ),
            //   // subtitle: Padding(
            //   //   padding: EdgeInsets.all(8.0),
            //   //   child: Text("22 Km"),
            //   // ),
            //   leading: Icon(Icons.location_on),
            // ),
            ListTile(
              title: Text(
                LocaleKeys.OrganizedBy.tr,
                style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(organizer.full_name),
              ),
              leading: Icon(Icons.info),
            ),
            ListTile(
              title: Text(
                LocaleKeys.Description.tr,
                style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(widget.event.description),
              ),
              leading: Icon(Icons.event),
            ),
            ListTile(
              onTap: () {
                ShapeBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)));

                showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    context: context,
                    shape: shape,
                    enableDrag: true,
                    backgroundColor: appPrimaryColor,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        maxChildSize: 0.8,
                        expand: false,
                        builder: (BuildContext context, ScrollController scrollController) {
                          return Container(
                            child: Column(
                              children: [
                                AppBar(
                                  shape: shape,
                                  centerTitle: true,
                                  actions: [
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(Icons.close))
                                  ],
                                  title: Container(
                                      child: Text(
                                    "$favorites ${LocaleKeys.Users.tr}",
                                    style: heading3_style,
                                  )),
                                  elevation: 2,
                                  automaticallyImplyLeading: false, // remove back button in appbar.
                                ),
                                Expanded(
                                  child: favoriteUsers.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: favoriteUsers.length,
                                          itemBuilder: (_, index) {
                                            return ItemAdminEventFavorite(userId: favoriteUsers[index]);
                                          },
                                        )
                                      : NotFound(message: LocaleKeys.NoUsers.tr),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              tileColor: appSecondaryColorDark,
              title: Text(
                LocaleKeys.FavoriteBy.tr,
                style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("$favorites ${LocaleKeys.Users.tr}"),
              ),
              leading: Icon(Icons.favorite),
            ),
            CustomChips(
              chipNames: widget.event.tags,
              unselectedColor: appPrimaryColor,
              textColor: Colors.white,
              selectable: false,
            ),
            Container(
              height: 40.h,
              margin: EdgeInsets.all(20.sp),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 0.3,
                  widthFactor: 2.5,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController mapController) async {
                      _controller.complete(mapController);
                      final position = await Geolocator.getCurrentPosition(forceAndroidLocationManager: true, desiredAccuracy: LocationAccuracy.high);

                      print(position);
                      mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 19),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    final pos = await Geolocator.getCurrentPosition(forceAndroidLocationManager: true, desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _checkLocationPermissions() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(LocaleKeys.LocationPermissionsDenied.tr);
      }
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        _checkLocationPermissions();
      }
      _getCurrentLocation();
    }
  }

  List<Widget> _buildPagesByLinks() {
    return images
        .map((e) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    e,
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  void onProfileInfo(User user) {
    if (mounted) {
      setState(() {
        this.organizer = user;
      });
    }
  }

  @override
  void onEventFavorites(List<String> users) {
    if (mounted) {
      setState(() {
        favorites = users.length;
        this.favoriteUsers = users;
      });
    }
  }

  @override
  void onMyFavorite(bool favorite) {
    // TODO: implement onMyFavorite
  }
}
