
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/views/screens/screen_homepage.dart';
import 'package:xlife/views/screens/screen_signin.dart';

import '../../generated/locales.g.dart';
import '../../helpers/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_container_design.dart';
import '../../widgets/custom_input_field.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String selectedGender = "Male";
  bool agreedTerm1 = false;
  bool agreedTerm2 = false;
  bool agreedTerm3 = false;

  @override
  Widget build(BuildContext context) {
    return CustomHeaderContainerDesign(
      showBack: false,
      title: Text(
        LocaleKeys.SignupTitle.tr,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomInputField(
                  hint: LocaleKeys.FullName.tr,
                  isPasswordField: false,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.name),
              CustomInputField(
                  hint: "Nickname",
                  isPasswordField: false,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.name),
              CustomInputField(
                  hint: LocaleKeys.EmailAddress.tr,
                  isPasswordField: false,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.emailAddress),
              CustomInputField(
                  hint: LocaleKeys.PhoneNumber.tr,
                  isPasswordField: false,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.phone),
              CustomInputField(
                  hint: LocaleKeys.Address.tr,
                  isPasswordField: false,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.streetAddress),
              CustomInputField(
                  hint: LocaleKeys.Password.tr,
                  isPasswordField: true,
                  fillColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Select Gender",
                  style: TextStyle(color: hintColor),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Transform.scale(
                      scale: 1.3,
                      child: RadioListTile(
                        dense: true,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        title: Text(LocaleKeys.Male.tr),
                        value: "Male",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Transform.scale(
                      scale: 1.3,
                      child: RadioListTile(
                        dense: true,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        title: Text(LocaleKeys.Female.tr),
                        value: "Female",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 0,
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
                    value: agreedTerm1,
                    onChanged: (value) {
                      setState(() {
                        agreedTerm1 = value!;
                      });
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
                    value: agreedTerm2,
                    onChanged: (value) {
                      setState(() {
                        agreedTerm2 = value!;
                      });
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
                    value: agreedTerm3,
                    onChanged: (value) {
                      setState(() {
                        agreedTerm3 = value!;
                      });
                    }),
              ),
              CustomButton(
                text: LocaleKeys.SignUp.tr,
                onPressed: () {
                  Get.offAll(ScreenHomepage());
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.AlreadyMember.tr),
                    TextButton(onPressed: () {
                      Get.to(SignInScreen());
                    }, child: Text(LocaleKeys.SignIn.tr))
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
    );
  }
}
