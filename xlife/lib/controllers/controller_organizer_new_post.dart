import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class ControllerOrganizerNewPost extends GetxController {


  var postImage = XFile("").obs;
  var postImageWeb = PickedFile("").obs;
  ImagePicker _picker = ImagePicker();
  ImagePickerPlugin _pickerPlugin = ImagePickerPlugin();

  Future<void> pickImage() async {

    if (kIsWeb){
      var pickedImage = await _pickerPlugin.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        print(pickedImage.path);
        postImageWeb.value = pickedImage;
        print(postImage.value.path);
      }
    } else {
      var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        print(pickedImage.path);
        postImage.value = pickedImage;
        print(postImage.value.path);
      }
    }
    update();
  }

}
