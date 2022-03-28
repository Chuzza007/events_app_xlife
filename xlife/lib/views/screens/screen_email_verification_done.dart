
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/screen_signup.dart';

import '../../generated/locales.g.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';

class EmailVerificationDoneScreen extends StatefulWidget {
  const EmailVerificationDoneScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationDoneScreenState createState() =>
      _EmailVerificationDoneScreenState();
}

class _EmailVerificationDoneScreenState
    extends State<EmailVerificationDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomHeaderContainerDesign(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/mail.png",
              height: Get.height * 0.1,
            ),
            Text(
              LocaleKeys.VerificationLinkSent.tr,
              style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.WeHaveSentVerificationLink.tr,
              textAlign: TextAlign.center,
              style: (GetPlatform.isWeb ? normal_h3Style_web : normal_h3Style),
            ),
            SizedBox(height: Get.height * 0.2,),
            CustomButton(text: LocaleKeys.Done.tr, onPressed: (){
              Get.offAll(SignupScreen());
            }),
          ],
        ),
      ),
      showBack: true,
    );
  }
}
