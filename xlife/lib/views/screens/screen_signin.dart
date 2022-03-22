import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_user_registration.dart';
import 'package:xlife/views/screens/admin/screen_admin_homepage.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_homepage.dart';
import 'package:xlife/views/screens/screen_forgot_password.dart';
import 'package:xlife/views/screens/user/screen_user_homepage.dart';
import 'package:xlife/widgets/custom_progress_widget.dart';

import '../../generated/locales.g.dart';
import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';
import '../../widgets/custom_input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool stayConnected = true;
  String adminEmail = "admin", adminPassword = "admin";
  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    return CustomHeaderContainerDesign(
      showBack: true,
      title: Text(LocaleKeys.SignInTitle.tr),
      child: GetBuilder<ControllerUserRegistration>(
        init: ControllerUserRegistration(),
        assignId: true,
        builder: (controller) {
          return CustomProgressWidget(
            loading: controller.isLoading.value,
            child: Form(
              key: controller.loginFormKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInputField(
                          hint: LocaleKeys.EmailAddress.tr,
                          isPasswordField: false,
                          fillColor: Colors.white,
                          onChange: (value) {
                            email = value.toString();
                          },
                          controller: controller.email_controller.value,
                          validator: (value) => controller
                              .validateEmail(value.toString()),
                          keyboardType: TextInputType.emailAddress),
                      CustomInputField(
                          hint: LocaleKeys.Password.tr,
                          isPasswordField: true,
                          fillColor: Colors.white,
                          onChange: (value) {
                            password = value.toString();
                          },
                          controller: controller.password_controller.value,
                          validator: (value) => controller
                              .validatePassword(value.toString()),
                          keyboardType: TextInputType.visiblePassword),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity:
                                ListTileControlAffinity.leading,
                            activeColor: appPrimaryColor,
                            title: Text(LocaleKeys.StayConnected.tr),
                            checkColor: Colors.white,
                            value: stayConnected,
                            onChanged: (value) {
                              setState(() {
                                stayConnected = value!;
                              });
                            }),
                      ),
                      SizedBox(
                        height: Get.height * 0.08,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(ForgotPasswordScreen());
                          },
                          child: Text(
                            LocaleKeys.ForgotPassword.tr + "?",
                            style: normal_h2Style.merge(
                                TextStyle(color: appPrimaryColor)),
                          )),
                      CustomButton(
                        text: LocaleKeys.SignIn.tr,
                        onPressed: () async {
                          if (email == adminEmail &&
                              password == adminPassword) {
                            Get.to(ScreenAdminHomepage());
                            return;
                          }
                          String response = await controller.login();
                          if (response == "success"){
                            Get.offAll(ScreenUserHomepage());
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.DontHaveAccount.tr),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(LocaleKeys.SignUp.tr))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
