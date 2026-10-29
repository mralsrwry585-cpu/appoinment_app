class Specialty {
  final String id;
  final String name;
  final String description;

  Specialty({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
