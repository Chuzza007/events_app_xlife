import 'dart:async';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/widgets/custom_button.dart';
import 'package:xlife/widgets/custom_chips.dart';

class ScreenUserEventDetails extends StatefulWidget {
  ScreenUserEventDetails({Key? key}) : super(key: key);

  @override
  _ScreenUserEventDetailsState createState() =>
      _ScreenUserEventDetailsState();
}

class _ScreenUserEventDetailsState
    extends State<ScreenUserEventDetails> {
  bool favorite = false;

  final Completer<GoogleMapController> _controller = Completer();

  LatLng initPosition =
      LatLng(0, 0); //initial Position cannot assign null values
  LatLng currentLatLng = LatLng(0.0,
      0.0); //initial currentPosition values cannot assign null values
  //initial permission status
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  List<String> images = [
    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
    "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2019/04/pjimage-1-1556188114.jpg",
  ];

  @override
  void initState() {
    _checkLocationPermissions();

    super.initState();
  }

  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DraggableHome(
          title: Text("Event Title"),
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
                        "Event Title",
                        style: (GetPlatform.isWeb ? heading3_style_web : heading3_style).copyWith(
                            color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        icon: ImageIcon(
                          AssetImage(
                              "assets/images/heart_$favorite.png"),
                          color: Colors.white,
                        ),
                      )
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
                      style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold).copyWith(
                        color: Colors.white
                      ),
                    ),
                  ))
            ],
          ),
          headerExpandedHeight: 0.55,
          stretchMaxHeight: .6,
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  favorite = !favorite;
                });
              },
              icon: ImageIcon(
                  AssetImage("assets/images/heart_$favorite.png")),
            )
          ],
          body: [
            ListTile(
              title: Text(
                "Distance",
                style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("22 Km"),
              ),
              leading: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text(
                "Organized By",
                style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("#####"),
              ),
              leading: Icon(Icons.info),
            ),
            ListTile(
              title: Text(
                "Description",
                style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("#####"),
              ),
              leading: Icon(Icons.event),
            ),
            CustomChips(
              chipNames: [
                "Birthday Party",
                "Drinks",
                "Dance",
                "Shows",
              ],
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
                    onMapCreated:
                        (GoogleMapController mapController) async {
                      _controller.complete(mapController);
                      final position =
                          await Geolocator.getCurrentPosition(
                              forceAndroidLocationManager: true,
                              desiredAccuracy: LocationAccuracy.high);

                      print(position);
                      mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(
                            LatLng(position.latitude,
                                position.longitude),
                            19),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 10.h, left: 10.sp, right: 10.sp),
              child: CustomButton(
                  text: "Favorite",
                  color: favorite ? Colors.green : hintColor,
                  onPressed: () {
                    setState(() {
                      favorite = !favorite;
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    final pos = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
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
        return Future.error('Location permissions are denied');
      }
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

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
}
