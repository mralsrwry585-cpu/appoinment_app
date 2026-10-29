import 'package:flutter/material.dart';

class Property {
  final String id;
  final String titleAr;
  final String locationAr;
  final String priceLabel;
  final String statusLabel;
  final String statusColorHex;
  final String imageAsset;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final bool isFavorite;

  const Property({
    required this.id,
    required this.titleAr,
    required this.locationAr,
    required this.priceLabel,
    required this.statusLabel,
    required this.statusColorHex,
    required this.imageAsset,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isFavorite = false,
  });

  Color get statusColor => Color(int.parse(statusColorHex));

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      titleAr: json['TitleAr'] ?? json['titleAr'] ?? '',
      locationAr: json['LocationAr'] ?? json['locationAr'] ?? '',
      priceLabel: json['PriceLabel'] ?? json['priceLabel'] ?? '',
      statusLabel: json['StatusLabel'] ?? json['statusLabel'] ?? '',
      statusColorHex:
          json['StatusColorHex'] ?? json['statusColorHex'] ?? '0xFFB76A40',
      imageAsset: json['ImageAsset'] ?? json['imageAsset'] ?? 'images/fila.jpg',
      bedrooms: json['Bedrooms'] is int
          ? json['Bedrooms']
          : int.tryParse(json['Bedrooms']?.toString() ?? '0') ?? 0,
      bathrooms: json['Bathrooms'] is int
          ? json['Bathrooms']
          : int.tryParse(json['Bathrooms']?.toString() ?? '0') ?? 0,
      area: json['Area'] is int
          ? json['Area']
          : int.tryParse(json['Area']?.toString() ?? '0') ?? 0,
      isFavorite: json['IsFavorite'] ?? json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'TitleAr': titleAr,
      'LocationAr': locationAr,
      'PriceLabel': priceLabel,
      'StatusLabel': statusLabel,
      'StatusColorHex': statusColorHex,
      'ImageAsset': imageAsset,
      'Bedrooms': bedrooms,
      'Bathrooms': bathrooms,
      'Area': area,
      'IsFavorite': isFavorite,
    };
  }
}
