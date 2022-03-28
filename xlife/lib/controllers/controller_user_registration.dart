import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/views/screens/user/screen_user_homepage.dart';

import '../helpers/constants.dart';

class ControllerUserRegistration extends GetxController {
  final email_controller = TextEditingController().obs;
  final password_controller = TextEditingController().obs;
  final full_name_controller = TextEditingController().obs;
  final nickname_controller = TextEditingController().obs;
  final address_controller = TextEditingController().obs;
  final phone_controller = TextEditingController().obs;
  final selected_gender = "male".obs;
  final isLoading = false.obs;
  final acceptedTerm1 = false.obs;
  final acceptedTerm2 = false.obs;
  final acceptedTerm3 = false.obs;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters at least (expect space)";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.length < 10) {
      return "Must be of 10 characters at least";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.length < 12 || !value.startsWith("92")) {
      return "Must be of 12 digits starting from 92";
    }
    return null;
  }

  Future<String> login() async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return "";
    }
    String email = email_controller.value.text;
    String password = password_controller.value.text;
    isLoading.value = true;
    String status = "";

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).then((value) {
          status = "success";
    })
    .catchError((error){
      Get.snackbar("Error", error.toString());
    });

    loginFormKey.currentState!.save();
    return status;

  }

  Future<String> signUp() async {
    final isValid = signupFormKey.currentState!.validate();
    if (!isValid) {
      return "";
    }

    if (!acceptedTerm1.value ||
        !acceptedTerm2.value ||
        !acceptedTerm3.value) {
      Get.snackbar(
          "Alert", "Make sure you accept all terms and conditions");
      return "";
    }

    String email = email_controller.value.text;
    String password = password_controller.value.text;
    String full_name = full_name_controller.value.text;
    String nickname = nickname_controller.value.text;
    String address = address_controller.value.text;
    String phone = phone_controller.value.text;
    String gender = selected_gender.value;

    isLoading.value = true;
    String status = "";

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password)
        .then((value) async {
      status = await _setDatabase(model.User(
          full_name: full_name,
          nick_name: nickname,
          email: email,
          phone: phone,
          address: address,
          password: password,
          gender: gender,
          acceptedTerms: true));
    }).catchError((error) {
      Get.snackbar("Error", error.toString());
    });

    signupFormKey.currentState!.save();
    update();
    return status;
  }

  Future<String> _setDatabase(model.User info) async {
    String response = "";
    isLoading.value = true;
    usersRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(info.toMap())
        .then((value) {
      response = "success";
      Get.off(ScreenUserHomepage());
    }).catchError((error) {
      response = error.toString();
    });
    return response;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
