import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_apply_as_organizer.dart';

import '../../../generated/locales.g.dart';
import '../../../helpers/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/custom_progress_widget.dart';

class ScreenApplyAsOrganizer extends StatefulWidget {
  const ScreenApplyAsOrganizer({Key? key}) : super(key: key);

  @override
  _ScreenApplyAsOrganizerState createState() => _ScreenApplyAsOrganizerState();
}

class _ScreenApplyAsOrganizerState extends State<ScreenApplyAsOrganizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become an organizer"),
      ),
      body: GetBuilder<ControllerApplyAsOrganizer>(
        assignId: true,
        init: ControllerApplyAsOrganizer(),
        builder: (controller) {
          return CustomProgressWidget(
            loading: controller.isLoading.value,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          controller: controller.full_name_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.name),
                      CustomInputField(
                          hint: "Nickname",
                          isPasswordField: false,
                          controller: controller.nickname_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.name),
                      CustomInputField(
                          hint: LocaleKeys.EmailAddress.tr,
                          isPasswordField: false,
                          controller: controller.email_controller.value,
                          fillColor: Colors.white,
                          asyncValidator: (value) async {
                            final response = await controller.validateEmail(value!);
                            return response;
                          },
                          keyboardType: TextInputType.emailAddress),
                      CustomInputField(
                          hint: LocaleKeys.PhoneNumber.tr,
                          isPasswordField: false,
                          controller: controller.phone_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validatePhone(value!);
                          },
                          keyboardType: TextInputType.phone),
                      CustomInputField(
                          hint: LocaleKeys.Address.tr,
                          isPasswordField: false,
                          controller: controller.address_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.streetAddress),
                      CustomInputField(
                          hint: "ID Card Number",
                          isPasswordField: false,
                          controller: controller.address_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                          keyboardType: TextInputType.number),
                      CustomInputField(
                          hint: LocaleKeys.Password.tr,
                          isPasswordField: true,
                          controller: controller.password_controller.value,
                          fillColor: Colors.white,
                          validator: (value) {
                            return controller.validatePassword(value!);
                          },
                          keyboardType: TextInputType.visiblePassword),
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
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                title: Text(LocaleKeys.Male.tr),
                                value: "male",
                                groupValue: controller.selected_gender.value,
                                onChanged: (value) {
                                  controller.selected_gender.value = value.toString();
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
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                title: Text(LocaleKeys.Female.tr),
                                value: "female",
                                groupValue: controller.selected_gender.value,
                                onChanged: (value) {
                                  controller.selected_gender.value = value.toString();
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
                            controlAffinity: ListTileControlAffinity.leading,
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
                            controlAffinity: ListTileControlAffinity.leading,
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
                            controlAffinity: ListTileControlAffinity.leading,
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
                        text: "Apply",
                        onPressed: () async {
                          String response = await controller.signUp();
                          if (response == "success"){
                            Get.back();
                            Get.snackbar("Success", "Your request submitted successfully. You'll receive a confirmation email", duration: const Duration(seconds: 5));
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
                                  Get.back();
                                },
                                child: Text(LocaleKeys.SignIn.tr)),
                          ],
                        ),
                      ),
                      const SizedBox(
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
