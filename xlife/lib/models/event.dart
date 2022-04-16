class Event {
  String id, title, description, organizer_id, image1, image2, image3;
  double latitude, longitude;
  int startTime, endTime;
  List<String> tags;
  double? entryFee;

  Event({
    required this.title,
    required this.id,
    required this.description,
    required this.organizer_id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,
    required this.tags,
    this.entryFee,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'id': this.id,
      'description': this.description,
      'organizer_id': this.organizer_id,
      'image1': this.image1,
      'image2': this.image2,
      'image3': this.image3,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'tags': this.tags,
      'entryFee': this.entryFee,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'] as String,
      id: map['id'] as String,
      description: map['description'] as String,
      organizer_id: map['organizer_id'] as String,
      image1: map['image1'] as String,
      image2: map['image2'] as String,
      image3: map['image3'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      startTime: map['startTime'] as int,
      endTime: map['endTime'] as int,
      tags: (map['tags'] as List<dynamic>).map((e) => e.toString().trim()).toList(),
      entryFee: map['entryFee'] as double,
    );
  }
}