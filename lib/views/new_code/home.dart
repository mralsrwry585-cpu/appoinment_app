import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/category_tag.dart';
import 'package:flutter_application_4/models/city_summary.dart';
import 'package:flutter_application_4/models/property.dart';
import 'package:flutter_application_4/models/real_estate_mock_data.dart';
import 'package:flutter_application_4/services/real_estate_repository.dart';
import 'package:flutter_application_4/services/real_estate_service.dart';
import 'package:flutter_application_4/theme/real_estate_theme.dart';
import 'package:flutter_application_4/widgets/category_tag_chip.dart';
import 'package:flutter_application_4/widgets/city_card_widget.dart';
import 'package:flutter_application_4/widgets/featured_property_card.dart';
import 'package:flutter_application_4/widgets/property_search_bar.dart';
import 'package:flutter_application_4/widgets/real_estate_bottom_nav.dart';

class RealEstateHomeView extends StatefulWidget {
  const RealEstateHomeView({super.key});

  static const routeName = '/real_estate_home';

  @override
  State<RealEstateHomeView> createState() => _RealEstateHomeViewState();
}

class _RealEstateHomeViewState extends State<RealEstateHomeView> {
  final RealEstateService _service = RealEstateService(
    MockRealEstateRepository(),
  );
  late List<CategoryTag> _categories;
  late List<CitySummary> _topCities;
  late List<Property> _featuredProperties;
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _categories = List<CategoryTag>.from(RealEstateMockData.categories);
    _topCities = List<CitySummary>.from(RealEstateMockData.topCities);
    _featuredProperties = [
      RealEstateMockData.featuredProperty,
      RealEstateMockData.featuredProperty,
      RealEstateMockData.featuredProperty,
    ];
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RealEstateTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 22),
                  PropertySearchBar(onChanged: (value) {}, onFilterTap: () {}),

                  const SizedBox(height: 20),
                  _buildSectionHeader(title: 'المدن', actionLabel: 'عرض الكل'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 112,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _topCities.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final city = _topCities[index];
                        return CityCardWidget(
                          city: city,
                          onTap: () => _onCityTap(index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildSectionHeader(
                    title: 'عقارات مميزة',
                    actionLabel: 'عرض الكل',
                  ),
                  SizedBox(height: 20, child: const SizedBox(height: 16)),
                  ..._featuredProperties.map(
                    (property) =>
                        FeaturedPropertyCard(property: property, onTap: () {}),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: RealEstateBottomNav(
        selectedIndex: _selectedNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'موقعك الحالي',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF726A67),
                ),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_pin, color: Color(0xFFC08761)),
                  Text(
                    'صنعاء,الحصبة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F2A28),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF5EEF0),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: RealEstateTheme.primary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CategoryTagChip(
            label: category.labelAr,
            isSelected: _selectedCategoryIndex == index,
            onTap: () => _onCategoryTap(index),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String actionLabel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2F2A28),
          ),
        ),
        Text(
          actionLabel,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFFB76A40),
          ),
        ),
      ],
    );
  }

  void _onCityTap(int index) {
    setState(() {
      _topCities = _topCities.map((city) {
        return CitySummary(
          id: city.id,
          nameAr: city.nameAr,
          locationHintAr: city.locationHintAr,
          availableLabelAr: city.availableLabelAr,
          isSelected: city.id == _topCities[index].id,
          imageAsset: city.imageAsset,
        );
      }).toList();
    });
  }
}
