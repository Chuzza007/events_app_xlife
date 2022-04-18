import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/views/screens/screen_signup.dart';
import 'package:xlife/widgets/custom_input_field.dart';

import '../../../generated/locales.g.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/styles.dart';
import '../../../models/user.dart' as model;
import '../../../widgets/custom_button.dart';

class ScreenOrganizerEditProfile extends StatefulWidget {
  ScreenOrganizerEditProfile({Key? key}) : super(key: key);

  @override
  _ScreenOrganizerEditProfileState createState() => _ScreenOrganizerEditProfileState();
}

class _ScreenOrganizerEditProfileState extends State<ScreenOrganizerEditProfile> implements ListenerProfileInfo {
  late model.User user;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool loading = true;

  final new_pass_controller = TextEditingController();
  final old_pass_controller = TextEditingController();

  bool passwordLoading = false;

  @override
  void initState() {
    getProfileInfo(uid, this, "organizer");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizer profile"),
      ),
      body: Center(
        child: loading
            ? CupertinoActivityIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0.sp),
                    child: Hero(
                      flightShuttleBuilder: flightShuttleBuilder,
                      tag: "edit_profile",
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: Get.height * 0.15,
                              width: Get.height * 0.15,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 5.sp),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(user.image_url ?? userPlaceholder))),
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
                                            "Profile Information",
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
                                                    "Name",
                                                    style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                                  ),
                                                  subtitle: Text(
                                                    user.full_name,
                                                    style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    "Email",
                                                    style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                                  ),
                                                  subtitle: Text(
                                                    user.email,
                                                    style: normal_h3Style.copyWith(color: Colors.black54),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    "Change Password",
                                                    style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(Icons.navigate_next),
                                                    onPressed: () {},
                                                  ),
                                                  onTap: () {
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
                                                                    "Change Password",
                                                                    style: normal_h2Style_bold,
                                                                  ),
                                                                  CustomInputField(
                                                                    label: "Old Password",
                                                                    isPasswordField: true,
                                                                    controller: old_pass_controller,
                                                                    keyboardType: TextInputType.visiblePassword,
                                                                  ),
                                                                  CustomInputField(
                                                                    label: "New Password",
                                                                    isPasswordField: true,
                                                                    controller: new_pass_controller,
                                                                    keyboardType: TextInputType.visiblePassword,
                                                                  ),
                                                                  CustomButton(
                                                                      text: "Change",
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
                                                                          Get.snackbar("Success", "Password changed successfully",
                                                                              colorText: Colors.white, backgroundColor: Colors.green);
                                                                        }
                                                                        setState(() {
                                                                          passwordLoading = false;
                                                                        });
                                                                      }),
                                                                ],
                                                              ),
                                                              secondChild: Text(
                                                                "Changing password...",
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
                                                    "My QR Code",
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
                                            "Terms",
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
                                          Text(
                                            "Others",
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
                                                    "Rate",
                                                    style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                                  ),
                                                  subtitle: Text(
                                                    "Rate us on app store",
                                                    style: normal_h3Style.copyWith(color: Colors.black45),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.navigate_next_outlined,
                                                    color: appTextColor,
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () {},
                                                  title: Text(
                                                    "Share",
                                                    style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                                  ),
                                                  subtitle: Text(
                                                    "Share this app with friends",
                                                    style: normal_h3Style.copyWith(color: Colors.black45),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.navigate_next_outlined,
                                                    color: appTextColor,
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () {},
                                                  title: Text(
                                                    "Win Gifts",
                                                    style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                                  ),
                                                  subtitle: Text(
                                                    "Win amazing gifts by downloading our app",
                                                    style: normal_h3Style.copyWith(color: Colors.black45),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.navigate_next_outlined,
                                                    color: appTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20),
                                            child: CustomButton(
                                              text: LocaleKeys.Logout.tr,
                                              onPressed: () {
                                                showIosDialog(
                                                  title: "Logout",
                                                  message: "Are you sure to logout?",
                                                  confirmText: "Logout",
                                                  cancelText: "Cancel",
                                                  onConfirm: () async {
                                                    await FirebaseAuth.instance.signOut();
                                                    Get.offAll(SignupScreen());
                                                  },
                                                  onCancel: () {
                                                    Get.back();
                                                  },
                                                  context: context,
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

  Future<String> changePassword(String oldPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(email: user!.email!, password: oldPassword);

    String response = "";

    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        response = "success";
      }).catchError((error) {
        Get.snackbar("Error", error.toString(), colorText: Colors.white, backgroundColor: Colors.red);
      });
    }).catchError((err) {
      Get.snackbar("Error", err.toString(), colorText: Colors.white, backgroundColor: Colors.red);
    });
    passwordLoading = false;
    return response;
  }
}
