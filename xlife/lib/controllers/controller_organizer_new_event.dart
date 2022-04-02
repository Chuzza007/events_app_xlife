import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ControllerOrganizerNewEvent extends GetxController {

  List<XFile> images = [XFile(""), XFile(""), XFile("")].obs;
  final ImagePicker _picker = ImagePicker();

  late Rx<int> startTimestamp;
  late Rx<int> endTimestamp;
  final Rx<DateTime> _currentDate = DateTime.now().obs;
  var tagsList = List<String>.empty(growable: true).obs;

  Future<void> pickImage({required int index}) async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      images[index] = pickedImage;
      print(images[index].path);
    }
    update();
  }

  @override
  void onInit() {

    startTimestamp = DateTime.now().millisecondsSinceEpoch.obs;
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

  // Future<String> _uploadImage(String contest_id, int index) async {
  //   Get.snackbar("Uploading Image", "Uploading organizer image to database");
  //   Reference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child("contests/${contest_id}_$index.png");
  //   final UploadTask uploadTask =
  //   storageReference.putFile(File(images[index].path));
  //
  //   uploadTask.snapshotEvents.listen((event) {
  //     showLoading.value = true;
  //   }).onError((error) {
  //     // do something to handle error
  //     showLoading.value = false;
  //   });
  //   final TaskSnapshot downloadUrl = (await uploadTask);
  //   final String url = await downloadUrl.ref.getDownloadURL();
  //   return url;
  // }

}
