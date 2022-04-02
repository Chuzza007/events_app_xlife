import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ControllerOrganizerNewPost extends GetxController {


  var postImage = XFile("").obs;
  var postImageWeb = PickedFile("").obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {


      var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        print(pickedImage.path);
        postImage.value = pickedImage;
        print(postImage.value.path);
      }

    update();
  }

}
