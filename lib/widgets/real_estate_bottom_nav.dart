import 'package:flutter/material.dart';
import 'package:flutter_application_4/theme/real_estate_theme.dart';

class RealEstateBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const RealEstateBottomNav({super.key, this.selectedIndex = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 22, right: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(
            icon: Icons.home_filled,
            label: 'الرئيسية',
            selected: selectedIndex == 0,
            onTap: () => onTap?.call(0),
          ),
          _NavItem(
            icon: Icons.map_outlined,
            label: 'الخريطة',
            selected: selectedIndex == 1,
            onTap: () => onTap?.call(1),
          ),
          GestureDetector(
            onTap: () => onTap?.call(2),
            child: Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: RealEstateTheme.primary,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFB76A40).withOpacity(0.24),
                    blurRadius: 18,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            ),
          ),
          _NavItem(
            icon: Icons.favorite_border,
            label: 'المفضلة',
            selected: selectedIndex == 3,
            onTap: () => onTap?.call(3),
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'حسابي',
            selected: selectedIndex == 4,
            onTap: () => onTap?.call(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFFB76A40) : const Color(0xFF726A67);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
