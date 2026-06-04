import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF0F0F0F);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF222222);
  static const Color surfaceBorder = Color(0xFF2A2A2A);
  static const Color surfaceHover = Color(0xFF252525);

  static const Color primary = Color(0xFFE8590C);
  static const Color primarySoft = Color(0xFF1A0F0A);
  static const Color primaryGlow = Color(0x33E8590C);
  static const Color primaryDark = Color(0xFFBF4609);

  static const Color accent = Color(0xFF1E293B);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF52525B);
  static const Color textOnPrimary = Colors.white;

  static const Color border = Color(0xFF2A2A2A);
  static const Color borderLight = Color(0xFF333333);

  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static const Color overlay = Color(0x99000000);
  static const Color glowOrange = Color(0x1AE8590C);

  static const Color lightBackground = Color(0xFFFAF6F1);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceLight = Color(0xFFFFF5F0);
  static const Color lightBorder = Color(0xFFEDE7DD);
  static const Color lightTextPrimary = Color(0xFF3E2723);
  static const Color lightTextSecondary = Color(0xFF6D4C41);
  static const Color lightTextMuted = Color(0xFFA1887F);
  static const Color lightTextOnPrimary = Colors.white;
  static const Color lightPrimarySoft = Color(0xFFFFEDD5);

  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color amber = Color(0xFFFFB300);
}

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.outfit(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.05,
        letterSpacing: -1.5,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.1,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.15,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.surfaceBorder),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.4)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      centerTitle: false,
    ),
  );
}

double responsiveFontSize(BuildContext context, double min, double max) {
  final width = MediaQuery.of(context).size.width;
  const double minWidth = 320;
  const double maxWidth = 1440;
  final ratio = ((width - minWidth) / (maxWidth - minWidth)).clamp(0.0, 1.0);
  return min + (max - min) * ratio;
}
