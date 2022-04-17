import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker_advance/google_places_picker_advance.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/controllers/controller_organizer_new_event.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/models/selected_location.dart';
import 'package:xlife/widgets/custom_button.dart';
import 'package:xlife/widgets/custom_chips.dart';
import 'package:xlife/widgets/custom_input_field.dart';

import '../../../helpers/constants.dart';
import '../../../widgets/custom_progress_widget.dart';

class ScreenOrganizerNewEvent extends StatelessWidget {
  LatLng initPosition = LatLng(0, 0); //initial Position cannot assign null values
  LatLng currentLatLng = LatLng(0.0, 0.0); //initial currentPosition values cannot assign null values
  //initial permission status
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    ControllerOrganizerNewEvent controller = Get.put(ControllerOrganizerNewEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text("New Event"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close)),
      ),
      body: Obx(() {
        return CustomProgressWidget(
          loading: controller.showLoading.isTrue,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeading("Event title", false),
                  CustomInputField(
                      hint: "Event title", isPasswordField: false, controller: controller.title_controller.value, keyboardType: TextInputType.text),
                  _buildHeading("Description", false),
                  CustomInputField(
                      hint: "Description",
                      isPasswordField: false,
                      maxLines: 10,
                      limit: 500,
                      controller: controller.description_controller.value,
                      showCounter: true,
                      keyboardType: TextInputType.text),
                  _buildHeading("Insert images", false),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: Get.height * 0.1,
                            child: controller.pickedImages[0].path != "" ? Container() : Icon(Icons.add),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: controller.pickedImages[0].path != ""
                                    ? DecorationImage(
                                        image: FileImage(File(controller.pickedImages[0].path)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, 1))]),
                          ),
                          onTap: () {
                            controller.pickImage(index: 0);
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: Get.height * 0.1,
                            child: controller.pickedImages[1].path != "" ? Container() : Icon(Icons.add),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: controller.pickedImages[1].path != ""
                                    ? DecorationImage(
                                        image: FileImage(File(controller.pickedImages[1].path)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, 1))]),
                          ),
                          onTap: () {
                            controller.pickImage(index: 1);
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: Get.height * 0.1,
                            child: controller.pickedImages[2].path != "" ? Container() : Icon(Icons.add),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: controller.pickedImages[2].path != ""
                                    ? DecorationImage(
                                        image: FileImage(File(controller.pickedImages[2].path)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, 1))]),
                          ),
                          onTap: () {
                            controller.pickImage(index: 2);
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildHeading("Pick event location", false),
                  Column(
                    children: [
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
                                  onMapCreated: (GoogleMapController mapController) async {
                                    final position = await Geolocator.getCurrentPosition(
                                        forceAndroidLocationManager: true, desiredAccuracy: LocationAccuracy.high);
                                    this.mapController = mapController;
                                    print(position);
                                    initPosition = LatLng(position.longitude, position.longitude);
                                    controller.pickedLocation.value = SelectedLocation(name: "", latitude: initPosition.latitude, longitude: initPosition.longitude);
                                    mapController.animateCamera(
                                      CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 19),
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
                                decoration: BoxDecoration(color: Colors.white, boxShadow: appBoxShadow, shape: BoxShape.circle),
                                child: Icon(Icons.edit),
                              ),
                              onTap: () async {
                                // controller.pickedLocation.value = await Get.to(LayoutPickLocation());
                                // double lat = controller.pickedLocation.value.latitude;
                                // double lng = controller.pickedLocation.value.longitude;
                                // if(mapController != null){
                                //   mapController!.animateCamera(
                                //     CameraUpdate.newLatLngZoom(LatLng(lat, lng), 19),
                                //   );
                                // }
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
                      AnimatedCrossFade(
                        firstChild: Text(
                          controller.pickedLocation.value.name,
                          style: normal_h4Style_bold,
                          textAlign: TextAlign.center,
                        ),
                        secondChild: Container(),
                        crossFadeState: controller.pickedLocation.value.name.isNotEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: Duration(seconds: 1),
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
                        DateTime selectedDate = await selectDate(context, DateTime.now().millisecondsSinceEpoch, controller.startTimestamp.value);
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
                                text: timestampToDateFormat(controller.startTimestamp.value, "dd MMM, yyyy"),
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                        DateTime start = DateTime.fromMillisecondsSinceEpoch(controller.startTimestamp.value);
                        DateTime selectedDate =
                            await selectDate(context, DateTime(start.year, start.month, start.day + 1).millisecondsSinceEpoch, null);
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
                                text: timestampToDateFormat(controller.endTimestamp.value, "dd MMM, yyyy"),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ])),
                      leading: Icon(Icons.access_time),
                    ),
                  ),
                  _buildHeading("Add tags", false),
                  CustomInputField(
                      hint: "Tag 1, Tag 2, Tag 3, ....",
                      isPasswordField: false,
                      onChange: (value) {
                        controller.buildTags(value.toString().trim());
                      },
                      keyboardType: TextInputType.text),
                  CustomChips(chipNames: controller.tagsList.value, selectable: false),
                  _buildHeading("Entry fee", true),
                  CustomInputField(
                      hint: "Min. 500", isPasswordField: false, controller: controller.fee_controller.value, keyboardType: TextInputType.number),
                  CustomButton(
                      text: "Add",
                      onPressed: () async {
                        String response = await controller.addNewEvent();
                        if (response == "success") {
                          Get.back();
                        }
                      }),
                ],
              ),
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
