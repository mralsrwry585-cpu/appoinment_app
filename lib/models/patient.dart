
class Patient {
  String id;
  String fullName;
  String email;
  String phone;
  String gender;
  DateTime? birthDate;
  String? profileImage;

  Patient({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    this.birthDate,
  
    this.profileImage,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    birthDate: json["birth_date"] != null ? DateTime.parse(json["birth_date"]) : null,
    profileImage: json["profile_image"],
  );
}