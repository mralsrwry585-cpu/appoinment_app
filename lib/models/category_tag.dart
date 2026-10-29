class CategoryTag {
  final String id;
  final String labelAr;
  final bool isSelected;

  const CategoryTag({
    required this.id,
    required this.labelAr,
    this.isSelected = false,
  });

  factory CategoryTag.fromJson(Map<String, dynamic> json) {
    return CategoryTag(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      labelAr: json['LabelAr'] ?? json['labelAr'] ?? '',
      isSelected: json['IsSelected'] ?? json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'LabelAr': labelAr,
      'IsSelected': isSelected,
    };
  }
}
