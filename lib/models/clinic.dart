class Clinic {
  final String id;
  final String name;
  final String city;
  final String address;
  final String phone;
  final String locationLink;

  Clinic({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phone,
    required this.locationLink,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        city: json['city'] ?? '',
        address: json['address'] ?? '',
        phone: json['phone'] ?? '',
        locationLink: json['location_link'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'address': address,
        'phone': phone,
        'location_link': locationLink,
      };
}
