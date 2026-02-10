import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Application text styles
///
/// Provides consistent typography across the app following Material Design 3 guidelines
class AppTextStyles {
  AppTextStyles._();

  // Font Family
  static const String fontFamily = 'Roboto';

  // Text Theme
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  // Display Styles (for large, expressive text)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.22,
  );

  // Headline Styles (for high-emphasis text)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.33,
  );

  // Title Styles (for medium-emphasis text)
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.27,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.50,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.43,
  );

  // Body Styles (for regular text)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.50,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.33,
  );

  // Label Styles (for buttons, labels, captions)
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  // Legacy compatibility (for existing code using old naming)
  static const TextStyle headline1 = displayLarge;
  static const TextStyle headline2 = displayMedium;
  static const TextStyle headline3 = displaySmall;
  static const TextStyle headline4 = headlineLarge;
  static const TextStyle headline5 = headlineMedium;
  static const TextStyle headline6 = headlineSmall;
  static const TextStyle subtitle1 = titleMedium;
  static const TextStyle subtitle2 = titleSmall;
  static const TextStyle bodyText1 = bodyLarge;
  static const TextStyle bodyText2 = bodyMedium;
  static const TextStyle caption = bodySmall;
  static const TextStyle overline = labelSmall;
  static const TextStyle button = labelLarge;

  // Custom Marketplace Styles
  static const TextStyle price = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.primary,
    height: 1.33,
  );

  static const TextStyle priceSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.primary,
    height: 1.33,
  );

  static const TextStyle bidAmount = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    fontFamily: fontFamily,
    color: AppColors.bidActive,
    height: 1.30,
  );

  static const TextStyle timer = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
    color: AppColors.warning,
    height: 1.50,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle badge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
    color: AppColors.onPrimary,
    height: 1.60,
  );
}
