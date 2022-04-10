class Reaction {
  String user_id;
  int timestamp;
  String value;

  Reaction({
    required this.user_id,
    required this.timestamp,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': this.user_id,
      'timestamp': this.timestamp,
      'value': this.value,
    };
  }

  factory Reaction.fromMap(Map<String, dynamic> map) {
    return Reaction(
      user_id: map['user_id'] as String,
      timestamp: map['timestamp'] as int,
      value: map['value'] as String,
    );
  }
}