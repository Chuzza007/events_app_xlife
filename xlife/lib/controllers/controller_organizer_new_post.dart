import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/models/post.dart';

class ControllerOrganizerNewPost extends GetxController {


  var postImage = XFile("").obs;
  var postImageWeb = PickedFile("").obs;
  final ImagePicker _picker = ImagePicker();
  final showLoading = false.obs;
  final title_controller = TextEditingController().obs;

  Future<void> pickImage() async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      postImage.value = pickedImage;
      print(postImage.value.path);
    }

    update();
  }


  Future<String> _uploadImage(String id) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("posts/${id}.png");
    final UploadTask uploadTask =
    storageReference.putFile(File(postImage.value.path));

    uploadTask.snapshotEvents.listen((event) {}).onError((error) {
      // do something to handle error
      Get.snackbar("Error", error.toString());
      showLoading.value = false;
    });
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future<String> addPost() async {
    String title = title_controller.value.text;
    if (title.isEmpty || postImage.value.path.isEmpty) {
      Get.snackbar("Error", "Title and image both required");
      return "";
    }
    showLoading.value = true;
    String response = "";
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    String url = await _uploadImage(id);

    String uid = FirebaseAuth.instance.currentUser!.uid;

    await postsRef.doc(id).set(Post(title: title,
        timestamp: int.parse(id),
        image: url,
        userType: "organizer",
        id: id,
        user_id: uid).toMap()).then((value) {
          response = "success";
    });

    return response;
  }


}
