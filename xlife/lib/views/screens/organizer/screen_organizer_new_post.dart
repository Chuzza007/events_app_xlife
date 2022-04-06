import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/controllers/controller_organizer_new_post.dart';
import 'package:xlife/widgets/custom_button.dart';

import '../../../helpers/styles.dart';
import '../../../widgets/custom_input_field.dart';

class ScreenOrganizerNewPost extends StatelessWidget {
  ScreenOrganizerNewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerOrganizerNewPost controller = Get.put(ControllerOrganizerNewPost());

    return Scaffold(
      appBar: AppBar(
        title: Text("Create new post"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeading("Post text", false),
              CustomInputField(
                  hint: "Write something....",
                  isPasswordField: false,
                  minLines: 1,
                  maxLines: 7,
                  controller: controller.title_controller.value,
                  limit: 500,
                  showCounter: true,
                  keyboardType: TextInputType.multiline),
              _buildHeading("Insert image", false),
              Obx(() {
                print(controller.postImage.value.path);
                return GestureDetector(
                  child: Container(
                    width: Get.width * .3,
                    margin: EdgeInsets.all(5),
                    height: Get.height * 0.1,
                    child: controller.postImage.value.path != "" ? Container() : Icon(Icons.add),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: (kIsWeb ? controller.postImageWeb.value.path : controller.postImage.value.path) != ""
                          ? DecorationImage(
                              image: kIsWeb
                                  ? NetworkImage(controller.postImageWeb.value.path)
                                  : FileImage(File(controller.postImage.value.path)) as ImageProvider,
                              fit: BoxFit.cover,
                            )
                          : null,
                      boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, 1))],
                    ),
                  ),
                  onTap: () {
                    controller.pickImage();
                  },
                );
              }),
              CustomButton(text: "Post", onPressed: () async {
                String response = await controller.addPost();
                if (response == "success"){
                  Get.back();
                }
              }),
            ],
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
            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            optional ? "(optional)" : "*",
            style: (GetPlatform.isWeb ? normal_h2Style_bold_web : normal_h2Style_bold).copyWith(
              color: optional ? Colors.grey : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
