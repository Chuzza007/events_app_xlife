import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_user_registration.dart';
import 'package:xlife/views/screens/screen_signin.dart';
import 'package:xlife/views/screens/user/screen_user_homepage.dart';
import 'package:xlife/widgets/custom_progress_widget.dart';

import '../../generated/locales.g.dart';
import '../../helpers/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';
import '../../widgets/custom_input_field.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomHeaderContainerDesign(
      showBack: false,
      title: Text(
        LocaleKeys.SignupTitle.tr,
      ),
      child: GetBuilder<ControllerUserRegistration>(
        assignId: true,
        init: ControllerUserRegistration(),
        builder: (controller) {
          return CustomProgressWidget(
            loading: controller.isLoading.value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: controller.signupFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomInputField(
                          hint: LocaleKeys.FullName.tr,
                          isPasswordField: false,
                          controller:
                              controller.full_name_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.name),
                      CustomInputField(
                          hint: "Nickname",
                          isPasswordField: false,
                          controller:
                              controller.nickname_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.name),
                      CustomInputField(
                          hint: LocaleKeys.EmailAddress.tr,
                          isPasswordField: false,
                          controller:
                              controller.email_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateEmail(value!);
                          },
                          keyboardType: TextInputType.emailAddress),
                      CustomInputField(
                          hint: LocaleKeys.PhoneNumber.tr,
                          isPasswordField: false,
                          controller:
                              controller.phone_controller.value,
                          fillColor: Colors.white,

                          validator: (value) {
                            return controller.validatePhone(value!);
                          },
                          keyboardType: TextInputType.phone),
                      CustomInputField(
                          hint: LocaleKeys.Address.tr,
                          isPasswordField: false,
                          controller:
                              controller.address_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.streetAddress),
                      CustomInputField(
                          hint: LocaleKeys.Password.tr,
                          isPasswordField: true,
                          controller:
                              controller.password_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validatePassword(value!);
                          },
                          keyboardType:
                              TextInputType.visiblePassword),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Select Gender",
                          style: TextStyle(color: hintColor),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Transform.scale(
                              scale: 1.1,
                              child: RadioListTile(
                                dense: true,
                                visualDensity: const VisualDensity(
                                  horizontal:
                                      VisualDensity.minimumDensity,
                                  vertical:
                                      VisualDensity.minimumDensity,
                                ),
                                title: Text(LocaleKeys.Male.tr),
                                value: "male",
                                groupValue:
                                    controller.selected_gender.value,
                                onChanged: (value) {
                                  controller.selected_gender.value =
                                      value.toString();
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Transform.scale(
                              scale: 1.1,
                              child: RadioListTile(
                                dense: true,
                                visualDensity: const VisualDensity(
                                  horizontal:
                                      VisualDensity.minimumDensity,
                                  vertical:
                                      VisualDensity.minimumDensity,
                                ),
                                title: Text(LocaleKeys.Female.tr),
                                value: "female",
                                groupValue:
                                    controller.selected_gender.value,
                                onChanged: (value) {
                                  controller.selected_gender.value =
                                      value.toString();
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity:
                                ListTileControlAffinity.leading,
                            activeColor: appPrimaryColor,
                            title: Text(LocaleKeys.term1.tr),
                            checkColor: Colors.white,
                            value: controller.acceptedTerm1.value,
                            onChanged: (value) {
                              controller
                                ..acceptedTerm1.value = value!
                                ..update();
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity:
                                ListTileControlAffinity.leading,
                            activeColor: appPrimaryColor,
                            title: Text(LocaleKeys.term2.tr),
                            checkColor: Colors.white,
                            value: controller.acceptedTerm2.value,
                            onChanged: (value) {
                              controller
                                ..acceptedTerm2.value = value!
                                ..update();
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity:
                                ListTileControlAffinity.leading,
                            activeColor: appPrimaryColor,
                            title: Text(LocaleKeys.term3.tr),
                            checkColor: Colors.white,
                            value: controller.acceptedTerm3.value,
                            onChanged: (value) {
                              controller
                                ..acceptedTerm3.value = value!
                                ..update();
                            }),
                      ),
                      CustomButton(
                        text: LocaleKeys.SignUp.tr,
                        onPressed: () async {
                          String response = await controller.signUp();
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
                            Text(LocaleKeys.AlreadyMember.tr),
                            TextButton(
                                onPressed: () {
                                  Get.to(SignInScreen());
                                },
                                child: Text(LocaleKeys.SignIn.tr))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
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
