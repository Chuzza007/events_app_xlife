import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/locales.g.dart';
import '../helpers/constants.dart';
import '../models/links.dart';

class ControllerAdminLinks extends GetxController {

  Links? links;
  Links? editLinks;

  Rx<TextEditingController> game_rules_controller =
      TextEditingController().obs;
  Rx<TextEditingController> privacy_policy_controller =
      TextEditingController().obs;
  Rx<TextEditingController> terms_controller =
      TextEditingController().obs;
  Rx<TextEditingController> help_controller =
      TextEditingController().obs;
  var showLoading = false.obs;

  @override
  void onInit() async {


    getLinks();
    links = await getSavedLinks();
    editLinks = await getSavedLinks();

    super.onInit();

  }



  void getLinks() {
    linksRef.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        links =
            Links.fromMap(change.doc.data() as Map<String, dynamic>);
        saveLinks(links!);
        update();
      });
    });
  }

  void updateLinks() async {
    String help = help_controller.value.text;
    String game_rules = game_rules_controller.value.text;
    String terms = terms_controller.value.text;
    String policy = privacy_policy_controller.value.text;
    if (help.isEmpty ||
        game_rules.isEmpty ||
        terms.isEmpty ||
        policy.isEmpty) {
      Get.snackbar(LocaleKeys.Error.tr, LocaleKeys.Fillallfields.tr);
      return;
    }
    showLoading.value = true;
    Links newLinks = Links(
        game_rules: game_rules,
        help: help,
        privacy_policy: policy,
        terms_conditions: terms);
    await linksRef
        .doc("all")
        .set(newLinks.toMap())
        .then((value) => () {
      showLoading.value = false;
      Get.snackbar(
          "Success".tr, "Links updated for all users");
    })
        .catchError((onError) {
      Get.snackbar(LocaleKeys.Error.tr, onError.toString());
      showLoading.value = false;
    });
    showLoading.value = false;
  }
}
