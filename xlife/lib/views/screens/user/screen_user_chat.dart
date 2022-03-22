import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as widget;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';

class ScreenUserChat extends StatefulWidget {
  const ScreenUserChat({Key? key}) : super(key: key);

  @override
  _ScreenUserChatState createState() => _ScreenUserChatState();
}

class _ScreenUserChatState extends State<ScreenUserChat> {
  List<types.Message> messages = [];
  types.User sender = types.User(
      id: "1234",
      firstName: "Me",
      lastSeen: DateTime.now().millisecondsSinceEpoch);
  types.User receiver = types.User(
      id: "1235",
      firstName: "Sami",
      lastName: "Khan",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/3/3a/Elton_John_Cannes_2019.jpg",
      lastSeen: DateTime.now().millisecondsSinceEpoch);

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  void _handleSendPressed(types.PartialText message) {
    final sentMessage = types.TextMessage(
      author: sender,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
      previewData: types.PreviewData(),
      type: types.MessageType.text,
    );

    final receivedMessage = types.TextMessage(
      author: receiver,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
      type: types.MessageType.text,
    );

    _addMessage(sentMessage);
    _addMessage(receivedMessage);
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
              Hero(
                  tag: "inbox_title",
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Text(
                      "${receiver.firstName} ${receiver.lastName}")),
              Text(
                "2 km away",
                style: normal_h5Style.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
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
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/3/3a/Elton_John_Cannes_2019.jpg"))),
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
          IconButton(
              onPressed: () {
                showOptionsBottomSheet(
                  context: context,
                  title: Text(
                    "More Options",
                    style: normal_h1Style_bold,
                  ),
                  options: [
                    ListTile(
                      title: Text("Block User"),
                      leading: Icon(Icons.block),
                    ),
                    ListTile(
                      title: Text("Delete Chat"),
                      leading: Icon(Icons.delete),
                    ),
                  ],
                  showSkipButton: true,
                  onItemSelected: (index) {
                    switch (index) {
                      case 3:
                        Get.defaultDialog(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                          content: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/block.png",
                                height: Get.height * 0.05,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Confirmation",
                                style: normal_h1Style_bold,
                              ),
                              Text(
                                "Are you sure, you want to block this  user?",
                                style: normal_h2Style,
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomButton(
                                    text: "Yes",
                                    onPressed: () {
                                      Get.back();
                                    },
                                    color: Colors.black54,
                                    height: Get.height * 0.06,
                                  )),
                                  Expanded(
                                      child: CustomButton(
                                          text: "No",
                                          height: Get.height * 0.06,
                                          onPressed: () {
                                            Get.back();
                                          })),
                                ],
                              ),
                            ],
                          ),
                        );
                        break;
                    }
                  },
                );
              },
              icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: widget.Chat(
            showUserNames: true,
            showUserAvatars: true,
            messages: messages,
            usePreviewData: true,
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
                        hint: "Type a message...",
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
                        if (controller.text.isNotEmpty) {
                          List<String> links =
                              checkForLinks(controller.text);
                          _handleSendPressed(
                            types.PartialText(
                                text: controller.text,
                                previewData: links.isNotEmpty
                                    ? types.PreviewData(
                                        link: links[0])
                                    : null),
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
                      "From Which City",
                      style: normal_h3Style_bold,
                    ),
                    Text(
                      "2 km Away",
                      style: normal_h4Style,
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
            user: sender),
      ),
    );
  }

  void _handleAttachmentPressed() {
    showOptionsBottomSheet(
      context: context,
      title: Text(
        "Select Attachment Option",
        style: normal_h1Style_bold,
      ),
      options: [
        ListTile(
          title: Text("Insert Images"),
        ),
        ListTile(
          title: Text("Choose file"),
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
    //               child: const Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text('Photo'),
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 _handleFileSelection();
    //               },
    //               child: const Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text('File'),
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () => Navigator.pop(context),
    //               child: const Align(
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
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index =
        messages.indexWhere((element) => element.id == message.id);
    final updatedMessage =
        messages[index].copyWith(previewData: previewData);

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
    RegExp exp = new RegExp(
        r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      builder: (builder) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                ),
                ListTile(
                  title: Text("Which City"),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text("user@test.com"),
                  leading: Icon(Icons.alternate_email),
                ),
                ListTile(
                  title: Text("+923086765898"),
                  leading: Icon(Icons.phone),
                ),
                ListTile(
                  title: Text("2 km away"),
                  leading: Icon(Icons.location_on),
                ),
                CustomButton(text: "Chat", onPressed: (){
                  Get.back();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
