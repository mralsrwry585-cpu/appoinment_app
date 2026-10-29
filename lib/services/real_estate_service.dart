import 'package:flutter_application_4/models/category_tag.dart';
import 'package:flutter_application_4/models/city_summary.dart';
import 'package:flutter_application_4/models/property.dart';
import 'package:flutter_application_4/services/real_estate_repository.dart';

class RealEstateService {
  final IRealEstateRepository repository;

  const RealEstateService(this.repository);

  Future<List<CategoryTag>> loadCategoryTags() {
    return repository.fetchCategories();
  }

  Future<List<CitySummary>> loadTopCities() {
    return repository.fetchTopCities();
  }

  Future<List<Property>> loadFeaturedProperties() {
    return repository.fetchFeaturedProperties();
  }

  Future<Property> loadPropertyDetails(String id) {
    return repository.fetchPropertyDetails(id);
  }
}
