import '../../core/constants/app_constants.dart';

/// Extension methods for String
extension StringExtensions on String {
  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(AppConstants.emailPattern).hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isValidPhoneNumber {
    return RegExp(AppConstants.phonePattern).hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    return RegExp(AppConstants.urlPattern).hasMatch(this);
  }

  /// Check if string is a valid username
  bool get isValidUsername {
    return RegExp(AppConstants.usernamePattern).hasMatch(this);
  }

  /// Check if string contains uppercase letters
  bool get hasUppercase {
    return contains(RegExp(r'[A-Z]'));
  }

  /// Check if string contains lowercase letters
  bool get hasLowercase {
    return contains(RegExp(r'[a-z]'));
  }

  /// Check if string contains digits
  bool get hasDigit {
    return contains(RegExp(r'[0-9]'));
  }

  /// Check if string contains special characters
  bool get hasSpecialCharacter {
    return contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Truncate string to specified length with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Remove all whitespace
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Check if string is null or empty
  bool get isNullOrEmpty {
    return isEmpty;
  }

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty {
    return isNotEmpty;
  }

  /// Convert string to int (returns null if invalid)
  int? toIntOrNull() {
    return int.tryParse(this);
  }

  /// Convert string to double (returns null if invalid)
  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  /// Check if string is numeric
  bool get isNumeric {
    return toDoubleOrNull() != null;
  }

  /// Get initials from name (e.g., "John Doe" -> "JD")
  String get initials {
    if (isEmpty) return '';
    final words = trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return words
        .take(2)
        .map((word) => word.substring(0, 1).toUpperCase())
        .join();
  }

  /// Convert to title case
  String get toTitleCase {
    return capitalizeWords;
  }

  /// Convert to camelCase
  String get toCamelCase {
    final words = split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return '';
    return words.first.toLowerCase() +
        words.skip(1).map((word) => word.capitalize).join();
  }

  /// Convert to snake_case
  String get toSnakeCase {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  /// Mask sensitive data (e.g., email, phone)
  String maskEmail() {
    if (!isValidEmail) return this;
    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${'*' * username.length}@$domain';
    }

    return '${username.substring(0, 2)}${'*' * (username.length - 2)}@$domain';
  }

  String maskPhone() {
    if (length < 4) return this;
    return '${'*' * (length - 4)}${substring(length - 4)}';
  }

  /// Parse enum from string
  T? toEnum<T>(List<T> values) {
    try {
      return values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() == toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}

/// Extension methods for nullable String
extension NullableStringExtensions on String? {
  /// Check if string is null or empty
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty {
    return this != null && this!.isNotEmpty;
  }

  /// Get value or default
  String orEmpty() {
    return this ?? '';
  }

  String orDefault(String defaultValue) {
    return this ?? defaultValue;
  }
}
