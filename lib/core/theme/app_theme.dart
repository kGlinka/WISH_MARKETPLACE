import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Application theme configuration
///
/// Provides consistent Material Design 3 theme across the app
/// Includes both light and dark theme variants
class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onError: AppColors.onError,
        onSurface: AppColors.onSurface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: _appBarTheme(Brightness.light),
      textTheme: AppTextStyles.textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme(Brightness.light),
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      bottomNavigationBarTheme: _bottomNavTheme(Brightness.light),
      floatingActionButtonTheme: _fabTheme,
      dialogTheme: _dialogTheme,
      dividerTheme: _dividerTheme,
      iconTheme: const IconThemeData(color: AppColors.iconColor),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        error: AppColors.errorDark,
        surface: AppColors.surfaceDark,
        onPrimary: AppColors.onPrimaryDark,
        onSecondary: AppColors.onSecondaryDark,
        onError: AppColors.onErrorDark,
        onSurface: AppColors.onSurfaceDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: _appBarTheme(Brightness.dark),
      textTheme: AppTextStyles.textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme(Brightness.dark),
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      bottomNavigationBarTheme: _bottomNavTheme(Brightness.dark),
      floatingActionButtonTheme: _fabTheme,
      dialogTheme: _dialogTheme,
      dividerTheme: _dividerTheme,
      iconTheme: const IconThemeData(color: AppColors.iconColorDark),
    );
  }

  // AppBar Theme
  static AppBarTheme _appBarTheme(Brightness brightness) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: brightness == Brightness.light
          ? AppColors.surface
          : AppColors.surfaceDark,
      foregroundColor: brightness == Brightness.light
          ? AppColors.onSurface
          : AppColors.onSurfaceDark,
      iconTheme: IconThemeData(
        color: brightness == Brightness.light
            ? AppColors.iconColor
            : AppColors.iconColorDark,
      ),
      titleTextStyle: AppTextStyles.headline6.copyWith(
        color: brightness == Brightness.light
            ? AppColors.onSurface
            : AppColors.onSurfaceDark,
      ),
    );
  }

  // Elevated Button Theme
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextStyles.button,
      ),
    );
  }

  // Outlined Button Theme
  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextStyles.button,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  // Text Button Theme
  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: AppTextStyles.button,
      ),
    );
  }

  // Input Decoration Theme
  static InputDecorationTheme _inputDecorationTheme(Brightness brightness) {
    return InputDecorationTheme(
      filled: true,
      fillColor: brightness == Brightness.light
          ? AppColors.inputFill
          : AppColors.inputFillDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      hintStyle: AppTextStyles.bodyText2.copyWith(
        color: brightness == Brightness.light
            ? AppColors.textSecondary
            : AppColors.textSecondaryDark,
      ),
      labelStyle: AppTextStyles.bodyText2,
      errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
    );
  }

  // Card Theme
  static CardThemeData get _cardTheme {
    return CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
    );
  }

  // Chip Theme
  static ChipThemeData get _chipTheme {
    return ChipThemeData(
      backgroundColor: AppColors.chipBackground,
      deleteIconColor: AppColors.iconColor,
      disabledColor: AppColors.disabled,
      selectedColor: AppColors.primary,
      secondarySelectedColor: AppColors.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: AppTextStyles.caption,
    );
  }

  // Bottom Navigation Bar Theme
  static BottomNavigationBarThemeData _bottomNavTheme(Brightness brightness) {
    return BottomNavigationBarThemeData(
      backgroundColor: brightness == Brightness.light
          ? AppColors.surface
          : AppColors.surfaceDark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: brightness == Brightness.light
          ? AppColors.textSecondary
          : AppColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: AppTextStyles.caption,
      unselectedLabelStyle: AppTextStyles.caption,
    );
  }

  // Floating Action Button Theme
  static FloatingActionButtonThemeData get _fabTheme {
    return const FloatingActionButtonThemeData(
      elevation: 4,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    );
  }

  // Dialog Theme
  static DialogThemeData get _dialogTheme {
    return DialogThemeData(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: AppTextStyles.headline6,
      contentTextStyle: AppTextStyles.bodyText2,
    );
  }

  // Divider Theme
  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: AppColors.divider,
      space: 1,
      thickness: 1,
    );
  }
}
