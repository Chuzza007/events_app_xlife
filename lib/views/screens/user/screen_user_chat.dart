import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_widget;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/message.dart' as model;
import 'package:xlife/models/user.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/fcm.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/not_found.dart';

class ScreenUserChat extends StatefulWidget {
  @override
  _ScreenUserChatState createState() => _ScreenUserChatState();

  User mReceiver;


  ScreenUserChat({
    required this.mReceiver,
  });
}

class _ScreenUserChatState extends State<ScreenUserChat> implements ListenerProfileInfo {

  User mUser = User(full_name: "full_name",
      nick_name: "nick_name",
      email: "email",
      phone: "phone",
      address: "address",
      password: "password",
      gender: "gender",
      type: "type",
      id: "id",
      last_seen: 0,
      notificationToken: "notificationToken");

  List<types.Message> messages = [];
  types.User sender = types.User(
    id: auth.FirebaseAuth.instance.currentUser!.uid,
    firstName: "Me",
    lastName: "",
    lastSeen: DateTime
        .now()
        .millisecondsSinceEpoch,
  );
  types.User receiver = types.User(
    id: "1235",
    firstName: "Loading",
    lastName: "",
    imageUrl: userPlaceholder,
    lastSeen: DateTime
        .now()
        .millisecondsSinceEpoch,
  );

  late TextEditingController controller;
  bool loading = true;

  String distance = "unknown";

  String uid = auth.FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    controller = TextEditingController();
    receiver = types.User(
        id: widget.mReceiver.id,
        lastName: "",
        firstName: widget.mReceiver.full_name,
        imageUrl: widget.mReceiver.image_url ?? userPlaceholder,
        lastSeen: widget.mReceiver.last_seen);

    getProfileInfo(uid, this, "user");

    super.initState();
  }

  void _handleSendPressed(types.PartialText message) async {
    // final sentMessage = types.TextMessage(
    //   author: sender,
    //   createdAt: DateTime
    //       .now()
    //       .millisecondsSinceEpoch,
    //   id: DateTime
    //       .now()
    //       .millisecondsSinceEpoch
    //       .toString(),
    //   text: message.text,
    //   previewData: types.PreviewData(),
    //   type: types.MessageType.text,
    // );
    //
    // final receivedMessage = types.TextMessage(
    //   author: receiver,
    //   createdAt: DateTime
    //       .now()
    //       .millisecondsSinceEpoch,
    //   id: DateTime
    //       .now()
    //       .millisecondsSinceEpoch
    //       .toString(),
    //   text: message.text,
    //   type: types.MessageType.text,
    // );
    //
    // _addMessage(sentMessage);
    // _addMessage(receivedMessage);

    int timestamp = DateTime
        .now()
        .millisecondsSinceEpoch;

    model.Message newMessage =
    model.Message(id: timestamp.toString(),
        sender_id: sender.id,
        receiver_id: receiver.id,
        text: message.text.trim(),
        timestamp: timestamp);

    await usersRef
        .doc("${sender.id}/chats/${receiver.id}")
        .set({"timestamp": newMessage.timestamp, "last_message": "Me: ${message.text}", "receiver_id": receiver.id}).then((value) {
      usersRef.doc("${sender.id}/chats/${receiver.id}/messages/$timestamp").set(newMessage.toMap()).then((value) {
        setState(() {
          controller.text = "";
        });
      });

      usersRef
          .doc("${receiver.id}/chats/${sender.id}")
          .set({"timestamp": newMessage.timestamp, "last_message": message.text, "receiver_id": sender.id}).then((value) {
        usersRef.doc("${receiver.id}/chats/${sender.id}/messages/$timestamp").set(newMessage.toMap());
      });
    }).catchError((error, stackTrace) {
      Get.snackbar(LocaleKeys.Error.tr
          , error.toString());
    });

    String response = await FCM.sendMessageSingle(mUser.full_name, message.text, widget.mReceiver.notificationToken);
    print(response);
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            _modalBottomSheetMenu();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(tag: "inbox_title", flightShuttleBuilder: flightShuttleBuilder, child: Text("${receiver.firstName} ${receiver.lastName}")),
              Text(
                /*"$distance"*/
                "${getLastSeen(widget.mReceiver.last_seen)}",
                style: (GetPlatform.isWeb ? normal_h5Style_web : normal_h5Style).copyWith(color: Colors.grey, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
        leadingWidth: Get.width * 0.25,
        leading: Container(
          margin: EdgeInsets.only(left: 5),
          child: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.arrow_back),
                Container(
                  width: Get.width * 0.1,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.contain, image: NetworkImage(receiver.imageUrl ?? userPlaceholder))),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Get.back();
            },
          ),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       // showOptionsBottomSheet(
          //       //   context: context,
          //       //   title: Text(
          //       //     "More Options",
          //       //     style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
          //       //   ),
          //       //   options: [
          //       //     // ListTile(
          //       //     //   title: Text("Block User"),
          //       //     //   leading: Icon(Icons.block),
          //       //     // ),
          //       //     ListTile(
          //       //       title: Text("Delete Chat"),
          //       //       leading: Icon(Icons.delete),
          //       //     ),
          //       //   ],
          //       //   showSkipButton: true,
          //       //   onItemSelected: (index) {
          //       //     switch (index) {
          //       //       case 3:
          //       //         Get.defaultDialog(
          //       //           contentPadding: EdgeInsets.symmetric(horizontal: 20),
          //       //           content: Column(
          //       //             mainAxisAlignment: MainAxisAlignment.center,
          //       //             children: [
          //       //               Image.asset(
          //       //                 "assets/images/block.png",
          //       //                 height: Get.height * 0.05,
          //       //               ),
          //       //               SizedBox(
          //       //                 height: 10,
          //       //               ),
          //       //               Text(
          //       //                 "Confirmation",
          //       //                 style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
          //       //               ),
          //       //               Text(
          //       //                 "Are you sure, you want to block this  user?",
          //       //                 style: (GetPlatform.isWeb ? normal_h2Style_web : normal_h2Style),
          //       //                 textAlign: TextAlign.center,
          //       //               ),
          //       //               Row(
          //       //                 children: [
          //       //                   Expanded(
          //       //                       child: CustomButton(
          //       //                     text: "Yes",
          //       //                     onPressed: () {
          //       //                       Get.back();
          //       //                     },
          //       //                     color: Colors.black54,
          //       //                     height: Get.height * 0.06,
          //       //                   )),
          //       //                   Expanded(
          //       //                       child: CustomButton(
          //       //                           text: "No",
          //       //                           height: Get.height * 0.06,
          //       //                           onPressed: () {
          //       //                             Get.back();
          //       //                           })),
          //       //                 ],
          //       //               ),
          //       //             ],
          //       //           ),
          //       //         );
          //       //         break;
          //       //     }
          //       //   },
          //       // );
          //
          //     },
          //     icon: Icon(Icons.more_vert_rounded))
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value.toString() == "Clear chat") {
                Get.defaultDialog(
                    title: LocaleKeys.ClearChat.tr,
                    middleText:LocaleKeys.AreYouSureToClearChat.tr,
                    textConfirm: LocaleKeys.Clear.tr,
                    textCancel: LocaleKeys.Cancel.tr
                    ,
                    onConfirm: () async {
                      Get.back();
                      await usersRef.doc(sender.id).collection("chats").doc(receiver.id).delete();
                      await usersRef.doc(sender.id).collection("chats").doc(receiver.id).collection("messages").get().then((value) {
                        for (var doc in value.docs) {
                          doc.reference.delete();
                        }
                      });
                      Get.back();
                    },
                    onCancel: () {
                      // Get.back();
                    }
                );
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            itemBuilder: (BuildContext context) {
              return {'Clear chat'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text(choice)),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: StreamBuilder<QuerySnapshot>(
            stream: usersRef.doc(sender.id).collection("chats").doc(receiver.id).collection("messages").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CupertinoActivityIndicator());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return NotFound(
                  message: LocaleKeys.NoInternetConnection.tr
                  ,
                  assetImage: "assets/images/nothing.png",
                );
              }
              var docs = snapshot.data!.docs;

              messages = docs
                  .map((e) => model.Message.fromMap(e.data() as Map<String, dynamic>))
                  .toList()
                  .map((e) => types.TextMessage(id: e.id, text: e.text, createdAt: e.timestamp, author: e.sender_id == sender.id ? sender : receiver))
                  .toList()
                  .reversed
                  .toList();

              return chat_widget.Chat(
                  showUserNames: true,
                  showUserAvatars: true,
                  messages: messages,
                  usePreviewData: true,
                  emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
                  customBottomWidget: Container(
                    width: Get.width,
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                        ),
                        boxShadow: appBoxShadow),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                              hint: LocaleKeys.TypeMessage.tr,
                              isPasswordField: false,
                              controller: controller,
                              showBorder: false,
                              isDense: true,
                              maxLines: 7,
                              minLines: 1,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              keyboardType: TextInputType.multiline),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              String text = controller.text.trim();
                              if (text.isNotEmpty) {
                                List<String> links = checkForLinks(text);
                                _handleSendPressed(
                                  types.PartialText(text: text, previewData: links.isNotEmpty ? types.PreviewData(link: links[0]) : null),
                                );
                                setState(() {
                                  controller.clear();
                                });
                              }
                            },
                            icon: ImageIcon(
                              AssetImage("assets/images/icon_send.png"),
                              color: appPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onMessageTap: (_, message) {
                    _handleMessageTap(message);
                  },
                  onPreviewDataFetched: (textMessage, previewData) {
                    _handlePreviewDataFetched(textMessage, previewData);
                  },
                  onAvatarTap: (user) {},
                  emptyState: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: Get.height * 0.15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      receiver.imageUrl.toString(),
                                    ))),
                          ),
                          Text(
                            "${LocaleKeys.From.tr}${widget.mReceiver.address}",
                            style: (GetPlatform.isWeb ? normal_h3Style_bold_web : normal_h3Style_bold),
                          ),
                          Text(
                            "$distance",
                            style: (GetPlatform.isWeb ? normal_h4Style_web : normal_h4Style),
                          )
                        ],
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.6),
                      )
                    ],
                  ),
                  onSendPressed: (text) {
                    _handleSendPressed(text);
                  },
                  user: sender);
            }),
      ),
    );
  }

  void _handleAttachmentPressed() {
    showOptionsBottomSheet(
      context: context,
      title: Text(
        LocaleKeys.SelectAttachmentOption.tr
        ,
        style: (GetPlatform.isWeb ? normal_h1Style_bold_web : normal_h1Style_bold),
      ),
      options: [
        ListTile(
          title: Text(LocaleKeys.InsertImage.tr),
        ),
        ListTile(
          title: Text(LocaleKeys.ChooseFile.tr
          ),
        ),
      ],
      showSkipButton: true,
      onItemSelected: (index) {
        if (index == 0) {
          _handleImageSelection();
        } else {
          _handleFileSelection();
        }
      },
    );
    //
    // showModalBottomSheet<void>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return SafeArea(
    //       child: SizedBox(
    //         height: 144,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: <Widget>[
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 _handleImageSelection();
    //               },
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text('Photo'),
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 _handleFileSelection();
    //               },
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text('File'),
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () => Navigator.pop(context),
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text('Cancel'),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      final message = types.FileMessage(
        author: sender,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        mimeType: lookupMimeType(result.files.single.path ?? ''),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path ?? '',
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: sender,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(types.TextMessage message,
      types.PreviewData previewData,) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        messages[index] = updatedMessage;
      });
    });
  }

  void _handleRowPressed() {
    print("");
  }

  List<String> checkForLinks(String text) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    return matches.map((e) => e.toString()).toList();
  }

  void _insertText(String myText) {
    final text = controller.text;
    final textSelection = controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (builder) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: Get.height * 0.15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage(
                              receiver.imageUrl ?? userPlaceholder,
                            ))),
                  ),
                ),
                ListTile(
                  title: Text(widget.mReceiver.address ?? LocaleKeys.Unknown.tr),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text(widget.mReceiver.email),
                  leading: Icon(Icons.alternate_email),
                ),
                ListTile(
                  title: Text(widget.mReceiver.phone ?? LocaleKeys.Unknown.tr
                  ),
                  leading: Icon(Icons.phone),
                ),
                ListTile(
                  title: Text("$distance"),
                  leading: Icon(Icons.location_on),
                ),
                CustomButton(
                    text: LocaleKeys.Chat.tr
                    ,
                    onPressed: () {
                      Get.back();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  void getDistance() {
    if (currentPosition == null || widget.mReceiver.latitude == null) {
      distance = "unknown";
      return;
    }
    setState(() {
      distance =
      "${roundDouble((Geolocator.distanceBetween(
          currentPosition!.latitude, currentPosition!.longitude, widget.mReceiver.latitude ?? 0, widget.mReceiver.longitude ?? 0) / 1000),
          2)} ${LocaleKeys.KmAway.tr
      }";
    });
  }

  @override
  void onProfileInfo(User user) {
    // TODO: implement onProfileInfo
  }

}
