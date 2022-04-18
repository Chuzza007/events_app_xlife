class Post {
  String title;
  int timestamp;
  String image, userType, user_id;
  String id;

  Post({
    required this.title,
    required this.timestamp,
    required this.image,
    required this.userType,
    required this.user_id,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'timestamp': this.timestamp,
      'image': this.image,
      'userType': this.userType,
      'user_id': this.user_id,
      'id': this.id,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] as String,
      timestamp: map['timestamp'] as int,
      image: map['image'] as String,
      userType: map['userType'] as String,
      user_id: map['user_id'] as String,
      id: map['id'] as String,
    );
  }
}