class Comment{
  String user_id, text;
  int timestamp;

  Comment({
    required this.user_id,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': this.user_id,
      'text': this.text,
      'timestamp': this.timestamp,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      user_id: map['user_id'] as String,
      text: map['text'] as String,
      timestamp: map['timestamp'] as int,
    );
  }
}