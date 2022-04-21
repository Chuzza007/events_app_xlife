import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/views/screens/screen_signup.dart';
import 'package:xlife/widgets/custom_button.dart';

import '../../../generated/locales.g.dart';
import '../../../helpers/constants.dart';
import '../../../interfaces/listener_profile_info.dart';
import '../../../widgets/custom_input_field.dart';

class ScreenUserEditProfile extends StatefulWidget {
  ScreenUserEditProfile({Key? key}) : super(key: key);

  @override
  _ScreenUserEditProfileState createState() => _ScreenUserEditProfileState();
}

class _ScreenUserEditProfileState extends State<ScreenUserEditProfile> implements ListenerProfileInfo {

  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool loading = true;
  model.User user = model.User(full_name: "full_name",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      image_url: "",
      type: "type",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");

  XFile? oldPickedImage;
  ImagePicker _picker = ImagePicker();
  var showDpLoading = false;

  var old_pass_controller = TextEditingController();
  var new_pass_controller = TextEditingController();

  var old_name_controller = TextEditingController();
  var new_name_controller = TextEditingController();

  bool passwordLoading = false;
  bool nameLoading = false;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(LocaleKeys.MyProfile.tr),
      ),
      body: AnimatedCrossFade(
        firstChild: Container(
          color: appPrimaryColor,
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: Get.height * 0.15,
                          width: Get.height * 0.15,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5.sp),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image:
                              DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(user.image_url ?? userPlaceholder))),
                        ),
                        onTap: (){
                          getImage();
                        },
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Container(
                          height: Get.height * 0.04,
                          width: Get.height * 0.04,
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(Icons.edit),
                        ),
                      ),
                      Positioned(
                        child: Visibility(
                          visible: false,
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: []),
                    ),
                    Positioned(
                      child: Container(
                        alignment: Alignment.topCenter,
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              resizeToAvoidBottomInset: false,
                              body: Container(
                                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LocaleKeys.ProfileInformation.tr,
                                        style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.black12,
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                LocaleKeys.Name.tr
                                                ,
                                                style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                              ),
                                              subtitle: Text(
                                                user.full_name,
                                                style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  showModalBottomSheetMenu(
                                                    context: context,
                                                    content: StatefulBuilder(
                                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                                        return Container(
                                                          margin: EdgeInsets.all(20),
                                                          child: AnimatedCrossFade(
                                                            firstChild: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Text(
                                                                  LocaleKeys.ChangeName.tr,
                                                                  style: normal_h2Style_bold,
                                                                ),
                                                                CustomInputField(
                                                                  label: LocaleKeys.CurrentName.tr,
                                                                  isPasswordField: false,
                                                                  controller: old_name_controller,
                                                                  text: user.full_name,
                                                                  keyboardType: TextInputType.none,
                                                                ),
                                                                CustomInputField(
                                                                  label: LocaleKeys.NewName.tr,
                                                                  isPasswordField: false,
                                                                  controller: new_name_controller,
                                                                  keyboardType: TextInputType.visiblePassword,
                                                                ),
                                                                CustomButton(
                                                                    text: LocaleKeys.Change.tr,
                                                                    onPressed: () async {
                                                                      String oldName = old_name_controller.text;
                                                                      String newName = new_name_controller.text;

                                                                      if (oldName.isEmpty || newName.isEmpty) {
                                                                        Get.back();
                                                                        return;
                                                                      }
                                                                      setState(() {
                                                                        nameLoading = true;
                                                                      });
                                                                      await Future.delayed(Duration(seconds: 1));
                                                                      String response = await changeName(oldName, newName);
                                                                      print(response);
                                                                      if (response == "success") {
                                                                        Get.back();
                                                                        Get.snackbar(LocaleKeys.Success.tr, LocaleKeys.NameChangedSuccessfully.tr,
                                                                            colorText: Colors.white, backgroundColor: Colors.green);
                                                                      }
                                                                      setState(() {
                                                                        nameLoading = false;
                                                                      });
                                                                    }),
                                                              ],
                                                            ),
                                                            secondChild: Text(
                                                              LocaleKeys.ChangingName.tr,
                                                              style: normal_h3Style_bold,
                                                            ),
                                                            duration: Duration(milliseconds: 500),
                                                            crossFadeState: nameLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                LocaleKeys.Email.tr,
                                                style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                              ),
                                              subtitle: Text(
                                                user.email,
                                                style: normal_h3Style.copyWith(color: Colors.black54),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                LocaleKeys.ChangePassword.tr,
                                                style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.navigate_next),
                                                onPressed: () {},
                                              ),
                                              onTap: (){
                                                showModalBottomSheetMenu(
                                                  context: context,
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return Container(
                                                        margin: EdgeInsets.all(20),
                                                        child: AnimatedCrossFade(
                                                          firstChild: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Text(
                                                                LocaleKeys.ChangePassword.tr
                                                                ,
                                                                style: normal_h2Style_bold,
                                                              ),
                                                              CustomInputField(
                                                                label: LocaleKeys.OldPassword.tr,
                                                                isPasswordField: true,
                                                                controller: old_pass_controller,
                                                                keyboardType: TextInputType.visiblePassword,
                                                              ),
                                                              CustomInputField(
                                                                label: LocaleKeys.NewPassword.tr
                                                                ,
                                                                isPasswordField: true,
                                                                controller: new_pass_controller,
                                                                keyboardType: TextInputType.visiblePassword,
                                                              ),
                                                              CustomButton(
                                                                  text: LocaleKeys.Change.tr,
                                                                  onPressed: () async {
                                                                    String oldPassword = old_pass_controller.text;
                                                                    String newPassword = new_pass_controller.text;

                                                                    if (oldPassword.isEmpty || newPassword.isEmpty) {
                                                                      Get.back();
                                                                      return;
                                                                    }
                                                                    setState(() {
                                                                      passwordLoading = true;
                                                                    });
                                                                    await Future.delayed(Duration(seconds: 1));
                                                                    String response = await changePassword(oldPassword, newPassword);
                                                                    print(response);
                                                                    if (response == "success") {
                                                                      Get.back();
                                                                      Get.snackbar(LocaleKeys.Success.tr, LocaleKeys.PasswordChangedSuccessfully.tr,
                                                                          colorText: Colors.white, backgroundColor: Colors.green);
                                                                    }
                                                                    setState(() {
                                                                      passwordLoading = false;
                                                                    });
                                                                  }),
                                                            ],
                                                          ),
                                                          secondChild: Text(
                                                            LocaleKeys.Changingpassword.tr,
                                                            style: normal_h3Style_bold,
                                                          ),
                                                          duration: Duration(milliseconds: 500),
                                                          crossFadeState: passwordLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );

                                              },
                                            ),
                                            ListTile(
                                              title: Text(
                                                LocaleKeys.MyQRCode.tr,
                                                style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.navigate_next),
                                                onPressed: () {},
                                              ),
                                              leading: Icon(Icons.qr_code),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        LocaleKeys.Terms.tr,
                                        style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.black12,
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              onTap: () {},
                                              title: Text(
                                                LocaleKeys.HELP.tr,
                                                style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                                              ),
                                              trailing: Icon(
                                                Icons.navigate_next_outlined,
                                                color: appTextColor,
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {},
                                              title: Text(
                                                LocaleKeys.PRIVACYPOLICY.tr,
                                                style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                                              ),
                                              trailing: Icon(
                                                Icons.navigate_next_outlined,
                                                color: appTextColor,
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {},
                                              title: Text(
                                                LocaleKeys.TERMSANDCONDITIONS.tr,
                                                style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                                              ),
                                              trailing: Icon(
                                                Icons.navigate_next_outlined,
                                                color: appTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Text(
                                      //   LocaleKeys.Others.tr,
                                      //   style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
                                      // ),
                                      // Container(
                                      //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      //   padding: EdgeInsets.all(10),
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     color: Colors.black12,
                                      //   ),
                                      //   child: Column(
                                      //     children: [
                                      //       ListTile(
                                      //         onTap: () {},
                                      //         title: Text(
                                      //           LocaleKeys.Rate.tr,
                                      //           style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                      //         ),
                                      //         subtitle: Text(
                                      //           LocaleKeys.RateUsOnAppStore.tr,
                                      //           style: normal_h3Style.copyWith(color: Colors.black45),
                                      //         ),
                                      //         trailing: Icon(
                                      //           Icons.navigate_next_outlined,
                                      //           color: appTextColor,
                                      //         ),
                                      //       ),
                                      //       ListTile(
                                      //         onTap: () {},
                                      //         title: Text(
                                      //           LocaleKeys.Share.tr,
                                      //           style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                      //         ),
                                      //         subtitle: Text(
                                      //           LocaleKeys.ShareThisAppWithFriends.tr,
                                      //           style: normal_h3Style.copyWith(color: Colors.black45),
                                      //         ),
                                      //         trailing: Icon(
                                      //           Icons.navigate_next_outlined,
                                      //           color: appTextColor,
                                      //         ),
                                      //       ),
                                      //       ListTile(
                                      //         onTap: () {},
                                      //         title: Text(
                                      //           LocaleKeys.WinGifts.tr,
                                      //           style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                      //         ),
                                      //         subtitle: Text(
                                      //           LocaleKeys.WinAmazingGifts.tr,
                                      //           style: normal_h3Style.copyWith(color: Colors.black45),
                                      //         ),
                                      //         trailing: Icon(
                                      //           Icons.navigate_next_outlined,
                                      //           color: appTextColor,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 20),
                                        child: CustomButton(
                                          text: LocaleKeys.Logout.tr,
                                          onPressed: () {
                                            showIosDialog(
                                                context: context,
                                                title: LocaleKeys.Logout.tr,
                                                message: LocaleKeys.AllUserSuggestionsRemovedSureToLogout.tr,
                                                onConfirm: () {
                                                  FirebaseAuth.instance.signOut().then((value) async {
                                                    await removeUserSuggestions();
                                                    return Get.offAll(SignupScreen());
                                                  });
                                                },
                                                onCancel: () {
                                                  Get.back();
                                                },
                                                confirmText: LocaleKeys.Logout.tr,
                                                cancelText: LocaleKeys.Cancel.tr

                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        secondChild: Container(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        duration: Duration(seconds: 1),
        crossFadeState: loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }

  @override
  void onProfileInfo(model.User user) {
    if (mounted) {
      setState(() {
        loading = false;
        this.user = user;
      });
    }
  }

  void getInfo() async {
    getProfileInfo(uid, this, "user");
  }


  void getImage() async {
    XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    oldPickedImage = pickedImage;
    Get.defaultDialog(
        title: LocaleKeys.AreYouSureToUploadImage.tr,
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
        textConfirm: LocaleKeys.Yes.tr,
        confirmTextColor: Colors.white,
        textCancel: LocaleKeys.Cancel.tr
        ,
        radius: 0,
        onConfirm: () async {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          Get.back();
          Get.snackbar(LocaleKeys.PleaseWait.tr, LocaleKeys.UpdatingProfilePicture.tr,
              colorText: Colors.white, backgroundColor: Colors.black);
          String image_url = await _uploadImage(uid);
          await usersRef
              .doc(uid)
              .update({"image_url": image_url}).catchError((error) {
            Get.snackbar(LocaleKeys.Error.tr, error.toString());
          });
          Get.snackbar(
              LocaleKeys.Success.tr, LocaleKeys.ProfileImageUpdatedSuccessfully.tr
          );
          setState(() {
            showDpLoading = false;
          });
        },
        onCancel: () {
          Get.back();
        });
  }

  Future<String> _uploadImage(String uid) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile_images/${uid}.png");
    final UploadTask uploadTask =
    storageReference.putFile(File(oldPickedImage!.path));

    uploadTask.snapshotEvents.listen((event) {
      showDpLoading = true;
    }).onError((error) {
      // do something to handle error
      showDpLoading = false;
      Get.snackbar(LocaleKeys.Error.tr, error.toString());
    });


    setState(() {

    });
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(email: user!.email!, password: oldPassword);

    String response = "";

    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        response = "success";
        usersRef.doc(uid).update({"password":newPassword});
      }).catchError((error) {
        Get.snackbar(LocaleKeys.Error.tr
            , error.toString(), colorText: Colors.white, backgroundColor: Colors.red);
      });
    }).catchError((err) {
      Get.snackbar(LocaleKeys.Error.tr
          , err.toString(), colorText: Colors.white, backgroundColor: Colors.red);
    });
    passwordLoading = false;
    return response;
  }

  Future<String> changeName (String oldName, String newName) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String response = "";
    await usersRef.doc(uid).update({"full_name":newName}).then((value) {
      response = "success";
    });

    return response;
  }

}