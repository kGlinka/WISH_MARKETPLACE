import 'package:flutter/material.dart';

/// Application color palette
///
/// Centralized color definitions for consistent theming across the app
/// Includes both light and dark theme color variants
class AppColors {
  AppColors._();

  // Primary Colors (Light Theme)
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary Colors (Light Theme)
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Dark Theme Primary Colors
  static const Color primaryDarkTheme = Color(0xFF818CF8);
  static const Color onPrimaryDark = Color(0xFF000000);

  // Dark Theme Secondary Colors
  static const Color secondaryDarkTheme = Color(0xFF34D399);
  static const Color onSecondaryDark = Color(0xFF000000);

  // Background Colors
  static const Color background = Color(0xFFF9FAFB); // Gray 50
  static const Color backgroundDark = Color(0xFF111827); // Gray 900

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1F2937); // Gray 800

  static const Color onSurface = Color(0xFF111827);
  static const Color onSurfaceDark = Color(0xFFF9FAFB);

  // Error Colors
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);

  // Success Colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  // Warning Colors
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  // Info Colors
  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // Text Colors (Light Theme)
  static const Color textPrimary = Color(0xFF111827); // Gray 900
  static const Color textSecondary = Color(0xFF6B7280); // Gray 500
  static const Color textDisabled = Color(0xFF9CA3AF); // Gray 400
  static const Color textHint = Color(0xFFD1D5DB); // Gray 300

  // Text Colors (Dark Theme)
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // Gray 50
  static const Color textSecondaryDark = Color(0xFF9CA3AF); // Gray 400
  static const Color textDisabledDark = Color(0xFF6B7280); // Gray 500
  static const Color textHintDark = Color(0xFF4B5563); // Gray 600

  // Icon Colors
  static const Color iconColor = Color(0xFF6B7280); // Gray 500
  static const Color iconColorDark = Color(0xFF9CA3AF); // Gray 400

  // Border Colors
  static const Color border = Color(0xFFE5E7EB); // Gray 200
  static const Color borderDark = Color(0xFF374151); // Gray 700

  // Divider Colors
  static const Color divider = Color(0xFFE5E7EB); // Gray 200
  static const Color dividerDark = Color(0xFF374151); // Gray 700

  // Input Colors
  static const Color inputFill = Color(0xFFF3F4F6); // Gray 100
  static const Color inputFillDark = Color(0xFF374151); // Gray 700

  // Disabled State
  static const Color disabled = Color(0xFFE5E7EB); // Gray 200
  static const Color disabledDark = Color(0xFF4B5563); // Gray 600

  // Chip & Tag Colors
  static const Color chipBackground = Color(0xFFE0E7FF); // Indigo 100
  static const Color chipBackgroundDark = Color(0xFF312E81); // Indigo 900

  // Marketplace Specific Colors
  static const Color bidActive = Color(0xFF10B981); // Emerald 500
  static const Color bidInactive = Color(0xFF6B7280); // Gray 500
  static const Color bidWinning = Color(0xFFF59E0B); // Amber 500
  static const Color bidLost = Color(0xFFEF4444); // Red 500

  static const Color escrowPending = Color(0xFFF59E0B); // Amber 500
  static const Color escrowFunded = Color(0xFF3B82F6); // Blue 500
  static const Color escrowReleased = Color(0xFF10B981); // Emerald 500
  static const Color escrowRefunded = Color(0xFF6B7280); // Gray 500
  static const Color escrowDisputed = Color(0xFFEF4444); // Red 500

  // Rating Colors
  static const Color ratingFilled = Color(0xFFFBBF24); // Amber 400
  static const Color ratingEmpty = Color(0xFFE5E7EB); // Gray 200

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x40000000); // 25% black

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static const Color shadowColor = Color(0x1A000000); // 10% black
  static const Color shadowColorDark = Color(0x40000000); // 25% black
}
