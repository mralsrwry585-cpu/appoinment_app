class CitySummary {
  final String id;
  final String nameAr;
  final String locationHintAr;
  final String availableLabelAr;
  final bool isSelected;
  final String imageAsset;

  const CitySummary({
    required this.id,
    required this.nameAr,
    required this.locationHintAr,
    required this.availableLabelAr,
    this.isSelected = false,
    required this.imageAsset,
  });

  factory CitySummary.fromJson(Map<String, dynamic> json) {
    return CitySummary(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      nameAr: json['NameAr'] ?? json['nameAr'] ?? '',
      locationHintAr: json['LocationHintAr'] ?? json['locationHintAr'] ?? '',
      availableLabelAr: json['AvailableLabelAr'] ?? json['availableLabelAr'] ?? '',
      isSelected: json['IsSelected'] ?? json['isSelected'] ?? false,
      imageAsset: json['ImageAsset'] ?? json['imageAsset'] ?? 'assets/images/3.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'NameAr': nameAr,
      'LocationHintAr': locationHintAr,
      'AvailableLabelAr': availableLabelAr,
      'IsSelected': isSelected,
      'ImageAsset': imageAsset,
    };
  }
}
