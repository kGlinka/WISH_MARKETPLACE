import '../extensions/string_extensions.dart';
import '../../core/constants/app_constants.dart';

/// Form validation utilities
///
/// Provides reusable validators for common form fields
class FormValidators {
  FormValidators._();

  /// Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!value.isValidEmail) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }

    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must be less than ${AppConstants.maxPasswordLength} characters';
    }

    if (!value.hasUppercase) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.hasLowercase) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.hasDigit) {
      return 'Password must contain at least one number';
    }

    if (!value.hasSpecialCharacter) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validate password confirmation
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validate username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < AppConstants.minUsernameLength) {
      return 'Username must be at least ${AppConstants.minUsernameLength} characters';
    }

    if (value.length > AppConstants.maxUsernameLength) {
      return 'Username must be less than ${AppConstants.maxUsernameLength} characters';
    }

    if (!value.isValidUsername) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    return null;
  }

  /// Validate phone number
  static String? validatePhoneNumber(String? value, {bool required = true}) {
    if (value == null || value.isEmpty) {
      return required ? 'Phone number is required' : null;
    }

    if (!value.isValidPhoneNumber) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validate required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(
    String? value,
    int maxLength,
    String fieldName,
  ) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }

    return null;
  }

  /// Validate numeric input
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (int.tryParse(value) == null && double.tryParse(value) == null) {
      return '$fieldName must be a number';
    }

    return null;
  }

  /// Validate integer input
  static String? validateInteger(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (int.tryParse(value) == null) {
      return '$fieldName must be a whole number';
    }

    return null;
  }

  /// Validate price (amount in cents)
  static String? validatePrice(String? value, {int? minimum, int? maximum}) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }

    final double? price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid price';
    }

    if (price <= 0) {
      return 'Price must be greater than 0';
    }

    if (minimum != null && (price * 100) < minimum) {
      return 'Price must be at least \$${(minimum / 100).toStringAsFixed(2)}';
    }

    if (maximum != null && (price * 100) > maximum) {
      return 'Price must be less than \$${(maximum / 100).toStringAsFixed(2)}';
    }

    return null;
  }

  /// Validate URL
  static String? validateUrl(String? value, {bool required = true}) {
    if (value == null || value.isEmpty) {
      return required ? 'URL is required' : null;
    }

    if (!value.isValidUrl) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Validate date (must be in future)
  static String? validateFutureDate(DateTime? value, String fieldName) {
    if (value == null) {
      return '$fieldName is required';
    }

    if (value.isBefore(DateTime.now())) {
      return '$fieldName must be in the future';
    }

    return null;
  }

  /// Validate date range
  static String? validateDateRange(
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate == null) {
      return 'Start date is required';
    }

    if (endDate == null) {
      return 'End date is required';
    }

    if (endDate.isBefore(startDate)) {
      return 'End date must be after start date';
    }

    return null;
  }

  /// Validate listing title
  static String? validateListingTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }

    if (value.length < 5) {
      return 'Title must be at least 5 characters';
    }

    if (value.length > AppConstants.maxListingTitleLength) {
      return 'Title must be less than ${AppConstants.maxListingTitleLength} characters';
    }

    return null;
  }

  /// Validate listing description
  static String? validateListingDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }

    if (value.length < 20) {
      return 'Description must be at least 20 characters';
    }

    if (value.length > AppConstants.maxListingDescriptionLength) {
      return 'Description must be less than ${AppConstants.maxListingDescriptionLength} characters';
    }

    return null;
  }

  /// Validate bid amount
  static String? validateBidAmount(
    String? value, {
    required int currentBid,
    required int minimumIncrement,
  }) {
    if (value == null || value.isEmpty) {
      return 'Bid amount is required';
    }

    final double? bidAmount = double.tryParse(value);
    if (bidAmount == null) {
      return 'Please enter a valid bid amount';
    }

    final int bidCents = (bidAmount * 100).round();

    if (bidCents <= currentBid) {
      return 'Bid must be higher than current bid';
    }

    final int minimumBid = currentBid + minimumIncrement;
    if (bidCents < minimumBid) {
      return 'Minimum bid is \$${(minimumBid / 100).toStringAsFixed(2)}';
    }

    return null;
  }
}
