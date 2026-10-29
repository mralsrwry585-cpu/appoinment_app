
class User {
  String id;
  String fullName;

  String phone;
  String gender;

  String? location;

  User({
    required this.id,
    required this.fullName,

    required this.phone,
    required this.gender,
  
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["full_name"],

    phone: json["phone"],
    gender: json["gender"],
      location: json["location"],
  );
}