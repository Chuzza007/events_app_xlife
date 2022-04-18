import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker_advance/google_places_picker_advance.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/models/event.dart';

import '../../../controllers/controller_organizer_new_event.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/styles.dart';
import '../../../models/selected_location.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_chips.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/pick_location_screen.dart';

class ScreenOrganizerUpdateEvent extends StatefulWidget {

  Event event;


  @override
  _ScreenOrganizerUpdateEventState createState() =>
      _ScreenOrganizerUpdateEventState();

  ScreenOrganizerUpdateEvent({
    required this.event,
  });
}

class _ScreenOrganizerUpdateEventState
    extends State<ScreenOrganizerUpdateEvent> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;


  LatLng initPosition =
  LatLng(0, 0); //initial Position cannot assign null values
  // LatLng currentLatLng = LatLng(0.0,
  //     0.0); //initial currentPosition values cannot assign null values
  //initial permission status
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  late DateTime startDate, endDate;


  @override
  void initState() {
    startDate = DateTime.fromMillisecondsSinceEpoch(widget.event.startTime);
    endDate = DateTime.fromMillisecondsSinceEpoch(widget.event.endTime);
    initPosition = LatLng(widget.event.latitude, widget.event.longitude);

    setState(() {
      _kGooglePlex = CameraPosition(target: initPosition, zoom: 18);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ControllerOrganizerNewEvent controller =
    Get.put(ControllerOrganizerNewEvent());


    controller.images = [widget.event.image1, widget.event.image2, widget.event.image3];

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Event"),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeading("Event title", false),
                CustomInputField(
                    hint: "Event title",
                    text: widget.event.title,
                    isPasswordField: false,
                    controller: controller.title_controller.value,
                    keyboardType: TextInputType.text),
                _buildHeading("Description", false),
                CustomInputField(
                    hint: "Description",
                    isPasswordField: false,
                    maxLines: 10,
                    text: widget.event.description,
                    limit: 500,
                    controller: controller.description_controller.value,
                    showCounter: true,
                    keyboardType: TextInputType.text),
                _buildHeading("Event images", false),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      controller.images[0])),
                              boxShadow: [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 1))
                              ]),
                        ),
                        onTap: () {
                          controller.pickNewImage(index: 0, eventId: widget.event.id);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      controller.images[1])),
                              boxShadow: [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 1))
                              ]),
                        ),
                        onTap: () {
                          controller.pickNewImage(index: 1, eventId: widget.event.id);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      controller.images[2])),
                              boxShadow: [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 1))
                              ]),
                        ),
                        onTap: () {
                          controller.pickNewImage(index: 2, eventId: widget.event.id);
                        },
                      ),
                    ),
                  ],
                ),
                _buildHeading("Pick event location", false),
                Stack(
                  children: [
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
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController
                            mapController) async {
                              _controller.complete(mapController);
                              final position =
                              await Geolocator.getCurrentPosition(
                                  forceAndroidLocationManager: true,
                                  desiredAccuracy:
                                  LocationAccuracy.high);

                              this.mapController = mapController;
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
                    Positioned(
                      right: 10.w,
                      bottom: 10.w,
                      child: GestureDetector(
                        child: Container(
                          height: Get.height * 0.04,
                          width: Get.height * 0.04,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: appBoxShadow,
                              shape: BoxShape.circle),
                          child: Icon(Icons.edit),
                        ),
                        onTap: () async {
                          PickResult pickedLocation = await Get.to(PlacePicker(
                            apiKey: googleAPIKey,
                            useCurrentLocation: true,
                            forceAndroidLocationManager: true,
                            enableMyLocationButton: true,
                            initialPosition: initPosition,
                            autocompleteLanguage: "fr",
                            automaticallyImplyAppBarLeading: true,
                            onPlacePicked: (result) {
                              print(result.toMap());
                            },
                            popOnPickResult: true,
                          ));
                          double lat = pickedLocation.geometry!.location.lat;
                          double lng = pickedLocation.geometry!.location.lng;
                          String name = "${pickedLocation.name ?? "" + ","} ${pickedLocation.formattedAddress.toString()}";
                          controller.pickedLocation.value = SelectedLocation(
                            name: name,
                            latitude: lat,
                            longitude: lng,
                          );
                          initPosition = LatLng(lat, lng);
                          if (mapController != null) {
                            mapController!.animateCamera(
                              CameraUpdate.newLatLngZoom(initPosition, 19),
                            );
                          }
                        },
                      ),
                    ),

                  ],
                ),
                _buildHeading("Timings", false),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    onTap: () async {
                      DateTime selectedDate = await selectDate(
                          context,
                          DateTime.now().millisecondsSinceEpoch,
                          controller.startTimestamp.value);
                      controller.updateStartDate(selectedDate);
                    },
                    title: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: "Starting from "),
                              TextSpan(
                                  text: timestampToDateFormat(
                                      controller.startTimestamp.value,
                                      "dd MMM, yyyy"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ])),
                    leading: Icon(Icons.access_time),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                    onTap: () async {
                      DateTime start =
                      DateTime.fromMillisecondsSinceEpoch(
                          controller.startTimestamp.value);
                      DateTime selectedDate = await selectDate(
                          context,
                          DateTime(start.year, start.month,
                              start.day + 1)
                              .millisecondsSinceEpoch,
                          null);
                      controller.updateEndDate(selectedDate);
                    },
                    title: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: "Ending at "),
                              TextSpan(
                                  text: timestampToDateFormat(
                                      controller.endTimestamp.value,
                                      "dd MMM, yyyy"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ])),
                    leading: Icon(Icons.access_time),
                  ),
                ),
                _buildHeading("Add tags", false),
                CustomInputField(
                    hint: "Tag 1, Tag 2, Tag 3, ....",
                    text: widget.event.tags.toString().replaceAll("]", "").replaceAll("[", ""),
                    isPasswordField: false,
                    onChange: (value) {
                      controller.buildTags(value.toString().trim());
                    },
                    keyboardType: TextInputType.text),
                CustomChips(
                    chipNames: controller.tagsList.value,
                    selectable: false),
                _buildHeading("Entry fee", true),
                CustomInputField(
                    hint: "Min. 500",
                    isPasswordField: false,
                    text: widget.event.entryFee.toString(),
                    keyboardType: TextInputType.number),
                CustomButton(text: "Update", onPressed: () async {
                  String response = await controller.updateEvent(id: widget.event.id, event: widget.event);
                  if (response == "success"){
                    Get.back();
                    Get.snackbar("Success", "Event updated");
                  }
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeading(String title, bool optional) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            title,
            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            optional ? "(optional)" : "*",
            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold).copyWith(
              color: optional ? Colors.grey : Colors.red,
            ),
          ),
        ],
      ),
    );
  }


}
