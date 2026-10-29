import 'package:flutter_application_4/models/category_tag.dart';
import 'package:flutter_application_4/models/city_summary.dart';
import 'package:flutter_application_4/models/property.dart';
import 'package:flutter_application_4/models/real_estate_mock_data.dart';

abstract class IRealEstateRepository {
  Future<List<CategoryTag>> fetchCategories();
  Future<List<CitySummary>> fetchTopCities();
  Future<List<Property>> fetchFeaturedProperties();
  Future<Property> fetchPropertyDetails(String id);
}

class MockRealEstateRepository implements IRealEstateRepository {
  @override
  Future<List<CategoryTag>> fetchCategories() async {
    return Future.value(RealEstateMockData.categories);
  }

  @override
  Future<List<CitySummary>> fetchTopCities() async {
    return Future.value(RealEstateMockData.topCities);
  }

  @override
  Future<List<Property>> fetchFeaturedProperties() async {
    return Future.value([RealEstateMockData.featuredProperty]);
  }

  @override
  Future<Property> fetchPropertyDetails(String id) async {
    return Future.value(RealEstateMockData.featuredProperty);
  }
}
