import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/user.dart' as model;

class ControllerAdminNewOrganizer extends GetxController {
  XFile postImage = XFile("");
  final ImagePicker _picker = ImagePicker();
  final name_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final GlobalKey<FormState> newOrganizerFormKey = GlobalKey<FormState>();
  var showLoading = false;

  Future<void> pickImage() async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      postImage = pickedImage;
      print(postImage.path);
    }
    update();
  }

  Future<String?> validateLoginEmail(String value) async {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return await checkIfEmailExists(value) ? "Email already taken" : null;
  }

  Future<String> addOrganizer() async {
    String email = email_controller.text;
    String name = name_controller.text;
    String password = password_controller.text;
    String response = "";
    showLoading = true;
    update();

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      String uid = value.user!.uid;
      String image_url = postImage.path == "" ? "" : await _uploadImage(uid);

      response = await _setDatabase(model.User(
        id: uid,
        full_name: name,
        address: "",
        nick_name: "",
        gender: "",
        phone: "",
        type: "organizer",
        email: email,
        image_url: image_url,
        password: password,
      ));
    }).catchError((error){
      Get.snackbar("Error", error.toString());
    });
    showLoading = false;
    update();

    print("response: $response");
    return response;
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters at least (expect space)";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.length < 10) {
      return "Must be of 10 characters at least";
    }
    return null;
  }

  Future<bool> checkIfEmailExists(String email) async {
    bool response = false;
    print(email);

    final emailUsers = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (emailUsers.isNotEmpty){
      return true;
    }

    final QuerySnapshot organizersResult = await organizersRef.where('email', isEqualTo: email).limit(1).get();
    final QuerySnapshot usersResult = await usersRef.where('email', isEqualTo: email).limit(1).get();

    if (usersResult.docs.isNotEmpty || organizersResult.docs.isNotEmpty) {
      response = true;
    }
    return response;
  }

  Future<String> _setDatabase(model.User organizer) async {
    String response = "";
    await organizersRef.doc(organizer.id).set(organizer.toMap()).then((value) {
      response = "success";
    }).catchError((error){
      response = error.toString();
    });
    return response;
  }

  Future<String> _uploadImage(String id) async {
    Reference storageReference = FirebaseStorage.instance.ref().child("organizers/${id}.png");
    final UploadTask uploadTask = storageReference.putFile(File(postImage.path));

    uploadTask.snapshotEvents.listen((event) {
    }).onError((error) {
      // do something to handle error
      Get.snackbar("Error", error.toString());
    });
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }
}
