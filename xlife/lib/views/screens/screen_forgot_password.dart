
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/screen_email_verification_done.dart';

import '../../generated/locales.g.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';
import '../../widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  String enteredValue = "";

  @override
  Widget build(BuildContext context) {
    return CustomHeaderContainerDesign(
      title: Text(LocaleKeys.ForgotPassword.tr),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.EnterYourEmailReset.tr,
              textAlign: TextAlign.center,
              style: (GetPlatform.isWeb ? normal_h1Style_web : normal_h1Style),),
            SizedBox(
              height: Get.height * 0.1,
            ),
            CustomInputField(
                hint: LocaleKeys.EmailAddress.tr,
                isPasswordField: false,
                fillColor: Colors.white,
                onChange: (value){
                  enteredValue = value.toString();
                },
                keyboardType: TextInputType.emailAddress),
            SizedBox(
              height: Get.height * 0.1,
            ),
            CustomButton(text: LocaleKeys.Submit.tr, onPressed: () {
              if (enteredValue.isEmail){
                Get.to(EmailVerificationDoneScreen());
              } else {
                Get.snackbar("Alert", "Invalid Email");
              }
            })
          ],
        ),
      ),
      showBack: true,
    );
  }
}
