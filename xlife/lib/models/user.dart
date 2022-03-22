class User {
  String full_name, nick_name, email, phone, address, password, gender;
  String? image_url;
  bool acceptedTerms;
  double? latitude, longitude;

  User({
    required this.full_name,
    required this.nick_name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.gender,
    this.image_url,
    required this.acceptedTerms,
    this.latitude,
    this.longitude,
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
      'acceptedTerms': this.acceptedTerms,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      full_name: map['full_name'] as String,
      nick_name: map['nick_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      image_url: map['image_url'] as String,
      acceptedTerms: map['acceptedTerms'] as bool,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}