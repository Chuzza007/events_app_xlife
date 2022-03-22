import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:xlife/controllers/controller_admin_new_organizer.dart';

import '../../../helpers/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';

class ScreenAdminAddOrganizer extends StatelessWidget {
  const ScreenAdminAddOrganizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerAdminNewOrganizer controller =
        Get.put(ControllerAdminNewOrganizer());
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Organizer"),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeading("Email Address", false),
                CustomInputField(
                    hint: "organizer@test.com",
                    isPasswordField: false,
                    keyboardType: TextInputType.emailAddress),
                _buildHeading("Password", false),
                CustomInputField(
                    hint: "Password",
                    isPasswordField: false,
                    keyboardType: TextInputType.text),
                _buildHeading("Insert image", true),
                Obx(() {
                  print(controller.postImage.value.path);
                  return GestureDetector(
                    child: Container(
                      width: Get.width * .3,
                      margin: EdgeInsets.all(5),
                      height: Get.height * 0.1,
                      child: controller.postImage.value.path != ""
                          ? Container()
                          : Icon(Icons.add),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          image: controller.postImage.value.path != ""
                              ? DecorationImage(
                                  image: FileImage(File(controller
                                      .postImage.value.path)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2, offset: Offset(0, 1))
                          ]),
                    ),
                    onTap: () {
                      controller.pickImage();
                    },
                  );
                }),
                CustomButton(text: "Add", onPressed: () {
                  Get.back();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(String title, bool optional) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            title,
            style: normal_h2Style_bold,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            optional ? "(optional)" : "*",
            style: normal_h2Style_bold.copyWith(
              color: optional ? Colors.grey : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
