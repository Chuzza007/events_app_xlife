import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_admin_links.dart';
import 'package:xlife/widgets/custom_progress_widget.dart';

import '../../../generated/locales.g.dart';
import '../../../helpers/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';

class LinksLayout extends StatelessWidget {
  const LinksLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ControllerAdminLinks>();

    return Obx(() {
      return CustomProgressWidget(
        loading: controller.showLoading.value,
        child: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInputField(
                    label: LocaleKeys.GameRules.tr,
                    isPasswordField: false,
                    text: controller.links!.game_rules,
                    controller: controller.game_rules_controller.value,
                    keyboardType: TextInputType.text),
                CustomInputField(
                    label: LocaleKeys.HELP.tr,
                    isPasswordField: false,
                    text: controller.links!.help,
                    controller: controller.help_controller.value,
                    keyboardType: TextInputType.text),
                CustomInputField(
                    label: LocaleKeys.PRIVACYPOLICY.tr,
                    isPasswordField: false,
                    controller: controller.privacy_policy_controller.value,
                    text: controller.links!.privacy_policy,
                    keyboardType: TextInputType.text),
                CustomInputField(
                    label: LocaleKeys.TERMSANDCONDITIONS.tr,
                    isPasswordField: false,
                    controller: controller.terms_controller.value,
                    text: controller.links!.terms_conditions,
                    keyboardType: TextInputType.text),
                SizedBox(height: Get.height * 0.3,),
                CustomButton(
                  color: appPrimaryColor,
                  text: "Update",
                  onPressed: () {
                    controller.updateLinks();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
