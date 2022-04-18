import 'package:xlife/models/post.dart';
import 'package:xlife/models/user.dart' as model;
import '../models/comment.dart';
import '../models/reaction.dart';

class ListenerPostDetails {
  void onReactions(List<Reaction> reactions){}
  void onComments(List<Comment> comments){}
  void onUserListener (model.User user){}
  void onMyReaction (String? reaction){}
}