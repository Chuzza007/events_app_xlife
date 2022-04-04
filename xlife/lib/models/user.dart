class User {
  String full_name, email, password;
  String? image_url, nick_name, phone, address, gender;
  double? latitude, longitude;
  String type;
  String id;

  User({
    required this.full_name,
    required this.nick_name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.gender,
    this.image_url,
    this.latitude,
    this.longitude,
    required this.type,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': this.full_name,
      'nick_name': this.nick_name,
      'email': this.email,
      'phone': this.phone,
      'address': this.address,
      'password': this.password,
      'gender': this.gender,
      'image_url': this.image_url,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'type': this.type,
      'id': this.id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      full_name: map['full_name'] as String,
      nick_name: map['nick_name'] as String?,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      password: map['password'] as String,
      gender: map['gender'] as String?,
      image_url: map['image_url'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
      type: map['type'] as String,
      id: map['id'] as String,
    );
  }
}