
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/screen_signup.dart';

import '../../generated/locales.g.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';
import '../../widgets/custom_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomHeaderContainerDesign(
      title: Text(LocaleKeys.ResetPassword.tr),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(LocaleKeys.CreateNewPassword.tr),
            SizedBox(
              height: Get.height * 0.1,
            ),
            CustomInputField(
                hint: LocaleKeys.NewPassword.tr,
                isPasswordField: true,
                fillColor: Colors.white,
                keyboardType: TextInputType.visiblePassword),
            CustomInputField(
                hint: LocaleKeys.ConfirmPassword.tr,
                isPasswordField: true,
                fillColor: Colors.white,
                keyboardType: TextInputType.visiblePassword),
            CustomButton(
              text: LocaleKeys.UpdatePassword.tr,
              onPressed: () {
                Get.offAll(SignupScreen());
              },
            ),
          ],
        ),
      ),
      showBack: true,
    );
  }
}
