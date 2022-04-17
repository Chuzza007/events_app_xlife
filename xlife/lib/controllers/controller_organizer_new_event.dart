import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/models/selected_location.dart';

class ControllerOrganizerNewEvent extends GetxController {

  List<XFile> pickedImages = [XFile(""), XFile(""), XFile("")].obs;
  final ImagePicker _picker = ImagePicker();
  List<String> images = ["", "", ""].obs;


  late Rx<int> startTimestamp;
  late Rx<int> endTimestamp;
  final Rx<DateTime> _currentDate = DateTime
      .now()
      .obs;
  var tagsList = List<String>.empty(growable: true).obs;
  final showLoading = false.obs;
  final title_controller = TextEditingController().obs;
  final description_controller = TextEditingController().obs;
  final tags_controller = TextEditingController().obs;
  final fee_controller = TextEditingController().obs;
  Rx<SelectedLocation> pickedLocation = SelectedLocation(name: "", latitude: 0, longitude: 0).obs;

  Future<void> pickImage({required int index}) async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      pickedImages[index] = pickedImage;
      print(pickedImages[index].path);
    }
    update();
  }

  @override
  void onInit() {
    startTimestamp = DateTime
        .now()
        .millisecondsSinceEpoch
        .obs;
    _currentDate.value = DateTime(_currentDate.value.year,
        _currentDate.value.month, _currentDate.value.day + 2);
    endTimestamp = _currentDate.value.millisecondsSinceEpoch.obs;
    super.onInit();
  }


  void updateStartDate(DateTime selectedDate) {
    startTimestamp.value = selectedDate.millisecondsSinceEpoch;
    update();
  }

  void updateEndDate(DateTime selectedDate) {
    endTimestamp.value = selectedDate.millisecondsSinceEpoch;
    update();
  }

  void buildTags(String value) {
    if (value.isEmpty) {
      tagsList.clear();
      return;
    }
    List<String> split = value.split(',');
    tagsList.value = split;
    update();
  }

  Future<String> addNewEvent() async {
    String response = "";
    String title = title_controller.value.text;
    String description = description_controller.value.text;
    String entryFee = fee_controller.value.text;
    double lat = pickedLocation.value.latitude;
    double lng = pickedLocation.value.longitude;
    if (title.isEmpty || description.isEmpty || pickedImages[0].path.isEmpty || pickedImages[1].path.isEmpty || pickedImages[2].path.isEmpty || tagsList.value.isEmpty) {
      Get.snackbar("Error", "All fields and images are required");
      return "";
    }
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    showLoading.value = true;

    String image1 = await _uploadImage(id, 0);
    String image2 = await _uploadImage(id, 1);
    String image3 = await _uploadImage(id, 2);
    Event event = Event(title: title,
        description: description,
        id: id,
        organizer_id: FirebaseAuth.instance.currentUser!.uid,
        image1: image1,
        image2: image2,
        image3: image3,
        latitude: lat,
        longitude: lng,
        startTime: startTimestamp.value,
        endTime: endTimestamp.value,
        tags: tagsList.value, entryFee: entryFee.isEmpty ? 0 : double.parse(entryFee));

    await eventsRef.doc(id).set(event.toMap()).then((value) {
      response = "success";
    });

    return response;
  }

  Future<String> _uploadImage(String event_id, int index) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("events/${event_id}_$index.png");
    final UploadTask uploadTask =
    storageReference.putFile(File(pickedImages[index].path));

    uploadTask.snapshotEvents.listen((event) {}).onError((error) {
      // do something to handle error
      Get.snackbar("Error", error.toString());
      showLoading.value = false;
    });
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future<void> pickNewImage({required int index, required String eventId}) async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);

      Get.defaultDialog(
          title: "Are you sure to upload this image",
          content: Container(
            margin: EdgeInsets.all(10),
            height: Get.height * 0.2,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10)],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(pickedImage.path)),
                )),
          ),
          textConfirm: "Yes",
          confirmTextColor: Colors.white,
          textCancel: "Cancel",
          radius: 0,
          onConfirm: () async {
            Get.back();
            String image_url =
            await _uploadNewImage(eventId, index, pickedImage.path);
            images[index] = image_url;
            await eventsRef
                .doc(eventId)
                .update({"image${index+1}": images[index]}).catchError((error) {
              Get.snackbar("Error", error.toString());
            });
            Get.snackbar("Success".tr, "Image ${index + 1} updated");
            showLoading.value = false;
          },
          onCancel: () {
            Get.back();
          });
    }
    update();
  }

  Future<String> _uploadNewImage(String eventsId, int index, String path) async {
    Get.snackbar("Uploading Image", "Uploading organizer image to database");
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("events/${eventsId}_$index.png");
    final UploadTask uploadTask = storageReference.putFile(File(path));

    uploadTask.snapshotEvents.listen((event) {
      showLoading.value = true;
    }).onError((error) {
      // do something to handle error
      showLoading.value = false;
    });
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }


}
