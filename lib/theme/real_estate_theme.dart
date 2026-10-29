import 'package:flutter/material.dart';

class RealEstateTheme {
  static const Color primary = Color(0xFF1a1511);
  static const Color secondary = Color(0xFF2F2A28);
  static const Color background = Color(0xFFfcfaf6);
  static const Color surface = Color(0xFFc08761);
  static const Color mutedText = Color(0xFFf0e6dd);
  static const Color border = Color(0xFFE7E2DE);

  static ThemeData get themeData {
    return ThemeData(
      fontFamily: 'almarai',
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      highlightColor: primary.withOpacity(0.08),
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: Color(0xFF1a1511),
        background: background,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        iconTheme: IconThemeData(color: secondary),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'almarai',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: secondary,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'almarai',
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: secondary,
        ),
        displayMedium: TextStyle(
          fontFamily: 'almarai',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: secondary,
        ),
        titleLarge: TextStyle(
          fontFamily: 'almarai',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: secondary,
        ),
        titleMedium: TextStyle(
          fontFamily: 'almarai',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: secondary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'almarai',
          fontSize: 16,
          color: secondary,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'almarai',
          fontSize: 14,
          color: mutedText,
        ),
        bodySmall: TextStyle(
          fontFamily: 'almarai',
          fontSize: 12,
          color: mutedText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        elevation: 8,
        selectedItemColor: primary,
        unselectedItemColor: mutedText,
        selectedLabelStyle: TextStyle(
          fontFamily: 'almarai',
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'almarai',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
