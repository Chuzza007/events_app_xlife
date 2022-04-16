class Message {
  String id, sender_id, receiver_id, text;
  int timestamp;

  Message({
    required this.id,
    required this.sender_id,
    required this.receiver_id,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'sender_id': this.sender_id,
      'receiver_id': this.receiver_id,
      'text': this.text,
      'timestamp': this.timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      sender_id: map['sender_id'] as String,
      receiver_id: map['receiver_id'] as String,
      text: map['text'] as String,
      timestamp: map['timestamp'] as int,
    );
  }
}