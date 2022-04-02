class Organizer{

  String id, full_name, email, password;
  String? phone, address, gender;
  String? image_url;
  double? latitude, longitude;


  Organizer({
    required this.id,
    required this.full_name,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.gender,
    required this.image_url,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'full_name': this.full_name,
      'email': this.email,
      'password': this.password,
      'phone': this.phone,
      'address': this.address,
      'gender': this.gender,
      'image_url': this.image_url,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }

  factory Organizer.fromMap(Map<String, dynamic> map) {
    return Organizer(
      id: map['id'] as String,
      full_name: map['full_name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      gender: map['gender'] as String?,
      image_url: map['image_url'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
    );
  }
}