import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_user_registration.dart';
import 'package:xlife/views/screens/admin/screen_admin_homepage.dart';
import 'package:xlife/views/screens/organizer/screen_organizer_homepage.dart';
import 'package:xlife/views/screens/screen_forgot_password.dart';
import 'package:xlife/views/screens/user/screen_user_homepage.dart';
import 'package:xlife/widgets/custom_progress_widget.dart';

import '../../controllers/controller_admin_links.dart';
import '../../generated/locales.g.dart';
import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';
import '../../widgets/custom_input_field.dart';

class SignInScreen extends StatelessWidget {
  String adminEmail = "adminpolydigit974", adminPassword = "@Fiverrpolydigit974";
  // String adminEmail = "a", adminPassword = "a";
  String email = "", password = "";
  CustomInputField? emailField;

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
                      emailField = CustomInputField(
                          hint: LocaleKeys.EmailAddress.tr,
                          isPasswordField: false,
                          fillColor: Colors.white,
                          onChange: (value) {
                            email = value.toString();
                          },
                          controller: controller.email_controller.value,
                          asyncValidator: (value) async {
                            return await controller.validateLoginEmail(value.toString());
                          },
                          keyboardType: TextInputType.emailAddress),
                      CustomInputField(
                          hint: LocaleKeys.Password.tr,
                          isPasswordField: true,
                          fillColor: Colors.white,
                          onChange: (value) {
                            password = value.toString();
                          },
                          controller: controller.password_controller.value,
                          validator: (value) => controller.validatePassword(value.toString()),
                          keyboardType: TextInputType.visiblePassword),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            LocaleKeys.SignInAs.tr,
                            style: normal_h3Style_bold,
                          ),
                          Obx(() {
                            return Container(
                              width: Get.width * .3,
                              child: DropdownButton<String>(
                                icon: Icon(Icons.keyboard_arrow_down),
                                elevation: 8,
                                underline: SizedBox(),
                                hint: Text(LocaleKeys.LoginAs.tr),
                                value: controller.selectedRole.value,
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(LocaleKeys.User.tr),
                                    value: "users",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(LocaleKeys.Organizer.tr),
                                    value: "organizers",
                                  ),
                                ],
                                onChanged: (String? value) async {
                                  print(value);
                                  controller.selectedRole.value = value.toString();
                                  emailField!.validate();
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Obx(() {
                          return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: appPrimaryColor,
                              title: Text(LocaleKeys.StayConnected.tr),
                              checkColor: Colors.white,
                              value: controller.stayConnected.value,
                              onChanged: (value) {
                                controller.stayConnected.value = value!;
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
                            style: (GetPlatform.isWeb ? normal_h2Style_web : normal_h2Style).merge(TextStyle(color: appPrimaryColor)),
                          )),
                      CustomButton(
                        text: LocaleKeys.SignIn.tr,
                        onPressed: () async {
                          if (email == adminEmail && password == adminPassword) {
                            Get.to(ScreenAdminHomepage());
                            return;
                          }
                          String response = await controller.login();
                          if (response == "success") {
                            if (controller.selectedRole == "users") {
                              Get.offAll(ScreenUserHomepage());
                            } else if (controller.selectedRole == "organizers") {
                              Get.offAll(ScreenOrganizerHomepage());
                            } else {
                              Get.snackbar(LocaleKeys.Error, LocaleKeys.SomethingWentWrong.tr);
                            }
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
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
