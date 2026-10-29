import 'package:flutter/material.dart';
import 'package:flutter_application_4/theme/real_estate_theme.dart';

class CategoryTagChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  // تمرير الألوان الافتراضية مع إمكانية تغييرها من الخارج
  final Color activeColor;
  final Color inactiveColor;
  final Color textColor;

  const CategoryTagChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.activeColor = RealEstateTheme.primary,
    this.inactiveColor = const Color(0xFFE7E2DE),
    this.textColor = const Color(0xFF453E3A),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      decoration: BoxDecoration(
        color: isSelected ? activeColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? activeColor : inactiveColor),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: activeColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : textColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
