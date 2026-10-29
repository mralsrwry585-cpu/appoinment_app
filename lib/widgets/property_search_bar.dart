import 'package:flutter/material.dart';
import 'package:flutter_application_4/theme/real_estate_theme.dart';

class PropertySearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const PropertySearchBar({
    super.key,
    this.hintText = 'ابحث عن حي، معلم، أو مشروع...',
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFFB3ABA7),
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 12, right: 8),
            child: Icon(Icons.search, color: Color(0xFFB3ABA7)),
          ),
          suffixIcon: GestureDetector(
            onTap: onFilterTap,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5E9E0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.tune,
                color: RealEstateTheme.primary,
                size: 20,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
