class Organizer{

  String id, full_name, nick_name, email, phone, address, password, gender;
  String? image_url;
  bool acceptedTerms;
  bool pending;
  double? latitude, longitude;

  Organizer({
    required this.id,
    required this.full_name,
    required this.nick_name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.gender,
    this.image_url,
    required this.acceptedTerms,
    required this.pending,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': full_name,
      'nick_name': nick_name,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'gender': gender,
      'image_url': image_url,
      'acceptedTerms': acceptedTerms,
      'pending': pending,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Organizer.fromMap(Map<String, dynamic> map) {
    return Organizer(
      id: map['id'] as String,
      full_name: map['full_name'] as String,
      nick_name: map['nick_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      image_url: map['image_url'] as String,
      acceptedTerms: map['acceptedTerms'] as bool,
      pending: map['pending'] as bool,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}