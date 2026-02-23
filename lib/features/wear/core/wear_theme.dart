import 'package:flutter/material.dart';

/// Wear OS color palette optimized for AMOLED displays
class WearColors {
  WearColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryVariant = Color(0xFF4F46E5);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary colors
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryVariant = Color(0xFF059669);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Background colors - true black for AMOLED
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFF2D2D2D);

  // Content colors
  static const Color onBackground = Color(0xFFE5E5E5);
  static const Color onSurface = Color(0xFFE5E5E5);
  static const Color onSurfaceVariant = Color(0xFFB3B3B3);

  // Status colors
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF10B981);
  static const Color info = Color(0xFF3B82F6);

  // Bidding specific colors
  static const Color activeBid = Color(0xFF10B981);
  static const Color outbidRed = Color(0xFFEF4444);
  static const Color winningGold = Color(0xFFFBBF24);
}

/// Theme data for Wear OS
class WearTheme {
  WearTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: WearColors.background,
      colorScheme: const ColorScheme.dark(
        primary: WearColors.primary,
        onPrimary: WearColors.onPrimary,
        secondary: WearColors.secondary,
        onSecondary: WearColors.onSecondary,
        surface: WearColors.surface,
        onSurface: WearColors.onSurface,
        error: WearColors.error,
        onError: Colors.white,
      ),
      cardTheme: const CardThemeData(
        color: WearColors.surface,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WearColors.onBackground),
        displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: WearColors.onBackground),
        displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WearColors.onBackground),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: WearColors.onSurface),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: WearColors.onSurface),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WearColors.onSurface),
        bodyLarge: TextStyle(fontSize: 16, color: WearColors.onSurface),
        bodyMedium: TextStyle(fontSize: 14, color: WearColors.onSurface),
        bodySmall: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: WearColors.onSurface),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: WearColors.onSurface),
        labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: WearColors.onSurfaceVariant),
      ),
      iconTheme: const IconThemeData(
        color: WearColors.onSurface,
        size: 24,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(48, 48),
          backgroundColor: WearColors.primary,
          foregroundColor: WearColors.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
    );
  }
}
