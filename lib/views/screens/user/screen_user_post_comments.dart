import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/fcm.dart';
import 'package:xlife/interfaces/listener_post_details.dart';
import 'package:xlife/interfaces/listener_profile_info.dart';
import 'package:xlife/models/comment.dart';
import 'package:xlife/models/post.dart';
import 'package:xlife/models/reaction.dart';
import 'package:xlife/models/user.dart' as model;
import 'package:xlife/views/layouts/item_user_comment.dart';
import 'package:xlife/widgets/custom_input_field.dart';

class ScreenUserPostComments extends StatefulWidget {
  Post post;

  @override
  _ScreenUserPostCommentsState createState() => _ScreenUserPostCommentsState();

  ScreenUserPostComments({
    required this.post,
  });
}

class _ScreenUserPostCommentsState extends State<ScreenUserPostComments> implements ListenerPostDetails, ListenerProfileInfo {
  List<Comment> comments = [];
  bool loading = true;
  final controller = TextEditingController();

  String uid = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : "";
  String myName = "A user";
  String userToken = "";

  @override
  void initState() {
    getProfileInfo(uid, this, "user");
    getPostDetails(widget.post, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${comments.length} ${LocaleKeys.comments.tr}"),
      ),
      body: AnimatedCrossFade(
        firstChild: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: AnimatedCrossFade(
                firstChild: ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (_, index) {
                    return ItemUserComment(comment: comments[index]);
                  },
                ),
                secondChild: Container(
                  alignment: Alignment.center,
                  child: Text(LocaleKeys.NoComments.tr),
                ),
                duration: Duration(seconds: 1),
                crossFadeState: comments.length > 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              ),
            ),
            if (uid.isNotEmpty)
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomInputField(
                        isPasswordField: false,
                        keyboardType: TextInputType.text,
                        margin: EdgeInsets.only(top: 10),
                        label: LocaleKeys.YourComment.tr,
                        controller: controller,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          String commentText = controller.text;
                          String id = DateTime.now().millisecondsSinceEpoch.toString();
                          if (commentText.isNotEmpty) {
                            postsRef
                                .doc(widget.post.id)
                                .collection("comments")
                                .doc(id)
                                .set(Comment(user_id: uid, text: commentText, timestamp: int.parse(id)).toMap())
                                .then((value) {
                              setState(() {
                                controller.text = "";
                                FCM.sendMessageSingle("New comment", "$myName commented on your post \"${widget.post.title}\".", userToken);
                              });
                            });
                          }
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ),
            ),
          ],
        ),
        secondChild: Center(child: CupertinoActivityIndicator()),
        duration: Duration(seconds: 1),
        crossFadeState: loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }

  @override
  void onComments(List<Comment> comments) {
    if (mounted) {
      setState(() {
        loading = false;
        this.comments = comments;
      });
    }
  }

  @override
  void onMyReaction(String? reaction) {
    // TODO: implement onMyReaction
  }

  @override
  void onReactions(List<Reaction> reactions) {
    // TODO: implement onReactions
  }

  @override
  void onUserListener(model.User user) {
    userToken = user.notificationToken;
  }

  @override
  void onProfileInfo(model.User user) {
    myName = user.full_name;
  }
}
