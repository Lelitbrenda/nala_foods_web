import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFAF6F1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFF5F0);

  static const Color primary = Color(0xFFE8590C);
  static const Color accent = Color(0xFF1E293B);

  static const Color border = Color(0xFFEDE7DD);
  static const Color textPrimary = Color(0xFF3E2723);
  static const Color textSecondary = Color(0xFF6D4C41);
  static const Color textMuted = Color(0xFFA1887F);
  static const Color textOnPrimary = Colors.white;

  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);

  static const Color primarySoft = Color(0xFFFFEDD5);
  static const Color primaryDark = Color(0xFFBF4609);
  static const Color accentLight = Color(0xFFE2E8F0);

  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);

  static const Color amber = Color(0xFFFFB300);

  static const Color cardElevated = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'sans-serif',
    fontFamilyFallback: const ['Arial', 'Helvetica', 'Roboto'],
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.1),
      headlineMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.15),
      headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.2),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: AppColors.textSecondary, height: 1.6),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textSecondary, height: 1.5),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textMuted, height: 1.5),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
