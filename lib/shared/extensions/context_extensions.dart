import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  /// MediaQuery shortcuts
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Screen type helpers
  bool get isSmallScreen => screenWidth < 600;
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1200;
  bool get isLargeScreen => screenWidth >= 1200;

  /// Orientation helpers
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Keyboard helpers
  bool get isKeyboardVisible => viewInsets.bottom > 0;
  double get keyboardHeight => viewInsets.bottom;

  /// Navigation shortcuts
  NavigatorState get navigator => Navigator.of(this);

  void pop<T>([T? result]) => navigator.pop(result);

  Future<T?> push<T>(Route<T> route) => navigator.push(route);

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      navigator.pushNamed(routeName, arguments: arguments);

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments}) =>
      navigator.pushReplacementNamed(routeName, arguments: arguments);

  Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) =>
      navigator.pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  /// ScaffoldMessenger shortcuts
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
    );
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
    );
  }

  /// Dialog shortcuts
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }

  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => context.pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Bottom sheet shortcuts
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) => child,
    );
  }

  /// Focus shortcuts
  void unfocus() => FocusScope.of(this).unfocus();
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);

  /// Responsive padding
  EdgeInsets get responsivePadding {
    if (isSmallScreen) {
      return const EdgeInsets.all(16);
    } else if (isMediumScreen) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  /// Safe area values
  double get topSafeArea => padding.top;
  double get bottomSafeArea => padding.bottom;
  double get leftSafeArea => padding.left;
  double get rightSafeArea => padding.right;
}
