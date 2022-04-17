import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/constants.dart';

class ControllerUserProfile extends GetxController {


  XFile? oldPickedImage;
  ImagePicker _picker = ImagePicker();
  var showDpLoading = false.obs;

  void getImage() async {
    XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    oldPickedImage = pickedImage;
    Get.defaultDialog(
        title: "Are you sure to upload this image",
        content: Container(
          margin: EdgeInsets.all(10),
          height: Get.height * 0.2,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 10)],
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(oldPickedImage!.path)),
            ),
          ),
        ),
        textConfirm: "Yes",
        confirmTextColor: Colors.white,
        textCancel: "Cancel",
        radius: 0,
        onConfirm: () async {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          Get.back();
          Get.snackbar("Please Wait", "Updating your profile picture",
              colorText: Colors.white, backgroundColor: Colors.black);
          String image_url = await _uploadImage(uid);
          await usersRef
              .doc(uid)
              .update({"image_url": image_url}).catchError((error) {
            Get.snackbar("Error", error.toString());
          });
          Get.snackbar(
              "Success".tr, "Profile image updated successfully");
          showDpLoading.value = false;
        },
        onCancel: () {
          Get.back();
        });
    update();
  }

  Future<String> _uploadImage(String uid) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile_images/${uid}.png");
    final UploadTask uploadTask =
    storageReference.putFile(File(oldPickedImage!.path));

    uploadTask.snapshotEvents.listen((event) {
      showDpLoading.value = true;
    }).onError((error) {
      // do something to handle error
      showDpLoading.value = false;
      Get.snackbar("Error", error.toString());
    });

    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

}
