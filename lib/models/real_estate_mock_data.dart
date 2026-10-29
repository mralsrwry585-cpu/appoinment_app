import 'package:flutter_application_4/models/category_tag.dart';
import 'package:flutter_application_4/models/city_summary.dart';
import 'package:flutter_application_4/models/property.dart';

class RealEstateMockData {
  static const List<CategoryTag> categories = [
    CategoryTag(id: 'all', labelAr: 'الكل', isSelected: true),
    CategoryTag(id: 'apartments', labelAr: 'شقق'),
    CategoryTag(id: 'villas', labelAr: 'فلل'),
    CategoryTag(id: 'floors', labelAr: 'ادوار'),
    CategoryTag(id: 'lands', labelAr: 'اراضي'),
  ];

  static const List<CitySummary> topCities = [
    CitySummary(
      id: 'riyadh',
      nameAr: 'الرياض',
      locationHintAr: 'حي الملقا',
      availableLabelAr: '12 عقار',
      isSelected: true,
      imageAsset: 'assets/images/11.png',
    ),
    CitySummary(
      id: 'jeddah',
      nameAr: 'جدة',
      locationHintAr: 'حي الشاطئ',
      availableLabelAr: '8 عقارات',
      imageAsset: 'assets/images/2.jpg',
    ),
    CitySummary(
      id: 'dammam',
      nameAr: 'الدمام',
      locationHintAr: 'حي الراكة',
      availableLabelAr: '6 عقارات',
      imageAsset: 'assets/images/3.jpg',
    ),
  ];

  static const Property featuredProperty = Property(
    id: 'villa_01',
    titleAr: 'فيلا نرجس الملقة',
    locationAr: 'الرياض، حي الملقا',
    priceLabel: '4,500,000 ر.س',
    statusLabel: 'للبيع',
    statusColorHex: '0xFFB76A40',
    imageAsset: 'images/fila.jpg',
    bedrooms: 5,
    bathrooms: 6,
    area: 450,
    isFavorite: true,
  );
}
