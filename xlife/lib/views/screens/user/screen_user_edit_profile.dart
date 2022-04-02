import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/views/screens/screen_signup.dart';
import 'package:xlife/widgets/custom_button.dart';

import '../../../generated/locales.g.dart';
import '../../../helpers/constants.dart';

class ScreenUserEditProfile extends StatefulWidget {
  const ScreenUserEditProfile({Key? key}) : super(key: key);

  @override
  _ScreenUserEditProfileState createState() => _ScreenUserEditProfileState();
}

class _ScreenUserEditProfileState extends State<ScreenUserEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      body: Column(
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
                          image:
                              const DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider("https://hireme.ga/images/mubashar.png"))),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: Container(
                        height: Get.height * 0.04,
                        width: Get.height * 0.04,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.edit),
                      ),
                    ),
                    const Positioned(
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
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
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
                    margin: const EdgeInsets.only(top: 10),
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
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
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          resizeToAvoidBottomInset: false,
                          body: Container(
                            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Profile Information",
                                    style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    padding: const EdgeInsets.all(10),
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
                                            "Mubashar Hussain",
                                            style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {},
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Email",
                                            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                          ),
                                          subtitle: Text(
                                            "user@test.com",
                                            style: normal_h3Style.copyWith(color: Colors.black54),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "Change Password",
                                            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.navigate_next),
                                            onPressed: () {},
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            "My QR Code",
                                            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.navigate_next),
                                            onPressed: () {},
                                          ),
                                          leading: const Icon(Icons.qr_code),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Terms",
                                    style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    padding: const EdgeInsets.all(10),
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
                                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    padding: const EdgeInsets.all(10),
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
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: CustomButton(
                                      text: LocaleKeys.Logout.tr,
                                      onPressed: () {
                                        showIosDialog(
                                          context: context,
                                          title: "Logout",
                                          message: "Are you sure to logout?",
                                          onConfirm: (){
                                            FirebaseAuth.instance.signOut().then((value) {
                                              return Get.offAll(SignupScreen());
                                            });
                                          },
                                          onCancel: (){
                                            Get.back();
                                          },
                                          confirmText: "Logout",
                                          cancelText: "Cancel"
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
    );
  }
}
