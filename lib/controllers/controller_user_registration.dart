import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/views/screens/organizer/screen_organizer_homepage.dart';
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
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final selectedRole = "users".obs;
  final stayConnected = true.obs;

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  Future<String?> validateLoginEmail(String value) async {
    if (!GetUtils.isEmail(value)) {
      return LocaleKeys.ProvideValidEmail.tr;
    }
    return await checkIfEmailExists(value) ? null : LocaleKeys.EmailDoesNotExist.tr;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return LocaleKeys.PasswordMustBeSixCharacters.tr;
    }
    return null;
  }

  String? validateName(String value) {
    if (value.length < 10) {
      return LocaleKeys.MustBeTenCharacter.tr;
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.length < 12 || !value.startsWith("92")) {
      return LocaleKeys.MustBeTwelveToN.tr;
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

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      status = "success";
    }).catchError((error) {
      Get.snackbar(LocaleKeys.Error.tr, error.toString());
    });

    loginFormKey.currentState!.save();
    return status;
  }

  Future<String> signUp() async {
    final isValid = signupFormKey.currentState!.validate();
    if (!isValid) {
      return "";
    }

    if (!acceptedTerm1.value || !acceptedTerm2.value || !acceptedTerm3.value) {
      Get.snackbar(LocaleKeys.Alert.tr, LocaleKeys.MakeSureYouAcceptTermsCondition.tr);
      return "";
    }

    String email = email_controller.value.text;
    String password = password_controller.value.text;
    String fullName = full_name_controller.value.text;
    String nickname = nickname_controller.value.text;
    String address = address_controller.value.text;
    String phone = phone_controller.value.text;
    String gender = selected_gender.value;

    isLoading.value = true;
    String status = "";

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      status = await _setDatabase(model.User(
          id: value.user!.uid,
          full_name: fullName,
          nick_name: nickname,
          email: email,
          phone: phone,
          address: address,
          password: password,
          notificationToken: "",
          type: "user",
          gender: gender,
          last_seen: DateTime.now().millisecondsSinceEpoch));
    }).catchError((error) {
      Get.snackbar(LocaleKeys.Error.tr, error.toString());
    });

    signupFormKey.currentState!.save();
    update();
    return status;
  }

  Future<String> _setDatabase(model.User info) async {
    String response = "";
    isLoading.value = true;
    usersRef.doc(FirebaseAuth.instance.currentUser!.uid).set(info.toMap()).then((value) {
      response = "success";
      Get.off(ScreenUserHomepage());
    }).catchError((error) {
      response = error.toString();
    });
    return response;
  }

  Future<bool> checkIfEmailExists(String email) async {
    bool response = false;
    print(email);

    final QuerySnapshot result = await FirebaseFirestore.instance.collection(selectedRole.value).where('email', isEqualTo: email).limit(1).get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      response = true;
    }
    print(response);
    return response;
  }

  @override
  void onInit() async {
    fetchAllTags();
    var _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      selectedRole.value = "users";
      bool userExists = await checkIfEmailExists(_user.email!);
      if (userExists) {
        Get.offAll(ScreenUserHomepage());
      } else {
        selectedRole.value = "organizers";
        bool organizerExists = await checkIfEmailExists(_user.email!);
        if (organizerExists) {
          Get.offAll(ScreenOrganizerHomepage());
        }
      }
    }
    super.onInit();
  }
}
