import 'package:intl/intl.dart';

/// Utility class for currency formatting and operations
class CurrencyUtils {
  CurrencyUtils._();

  static const String defaultCurrency = 'USD';
  static const String defaultLocale = 'en_US';

  /// Format amount in cents to currency string (e.g., 1000 cents -> "$10.00")
  static String formatCents(int cents, {String? currency, String? locale}) {
    final amount = cents / 100.0;
    return formatAmount(amount, currency: currency, locale: locale);
  }

  /// Format decimal amount to currency string (e.g., 10.50 -> "$10.50")
  static String formatAmount(
    double amount, {
    String? currency,
    String? locale,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale ?? defaultLocale,
      symbol: _getCurrencySymbol(currency ?? defaultCurrency),
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format amount without currency symbol (e.g., 10.50 -> "10.50")
  static String formatAmountWithoutSymbol(
    double amount, {
    String? locale,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale ?? defaultLocale,
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(amount).trim();
  }

  /// Parse currency string to cents (e.g., "$10.50" -> 1050 cents)
  static int? parseToCents(String currencyString) {
    try {
      // Remove currency symbols and parse
      final cleaned = currencyString.replaceAll(RegExp(r'[^\d.]'), '');
      final amount = double.parse(cleaned);
      return (amount * 100).round();
    } catch (e) {
      return null;
    }
  }

  /// Parse currency string to double (e.g., "$10.50" -> 10.50)
  static double? parseToDouble(String currencyString) {
    try {
      final cleaned = currencyString.replaceAll(RegExp(r'[^\d.]'), '');
      return double.parse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Convert cents to double (e.g., 1050 cents -> 10.50)
  static double centsToDouble(int cents) {
    return cents / 100.0;
  }

  /// Convert double to cents (e.g., 10.50 -> 1050 cents)
  static int doubleToCents(double amount) {
    return (amount * 100).round();
  }

  /// Format compact currency (e.g., 1000 -> "$1K", 1000000 -> "$1M")
  static String formatCompact(int cents, {String? currency}) {
    final amount = cents / 100.0;
    final symbol = _getCurrencySymbol(currency ?? defaultCurrency);

    if (amount >= 1000000000) {
      return '$symbol${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return '$symbol${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '$symbol${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return formatCents(cents, currency: currency);
    }
  }

  /// Get currency symbol for currency code
  static String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'CNY':
        return '¥';
      case 'INR':
        return '₹';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'CHF':
        return 'Fr';
      case 'BRL':
        return 'R\$';
      case 'MXN':
        return 'MX\$';
      default:
        return '\$';
    }
  }

  /// Calculate percentage of amount
  static int calculatePercentage(int cents, double percentage) {
    return ((cents * percentage) / 100).round();
  }

  /// Calculate fee amount (e.g., 5% of 1000 cents = 50 cents)
  static int calculateFee(int cents, double feePercentage) {
    return calculatePercentage(cents, feePercentage);
  }

  /// Calculate total with fee
  static int calculateTotalWithFee(int cents, double feePercentage) {
    return cents + calculateFee(cents, feePercentage);
  }

  /// Validate minimum amount
  static bool isValidMinimum(int cents, int minimumCents) {
    return cents >= minimumCents;
  }

  /// Validate maximum amount
  static bool isValidMaximum(int cents, int maximumCents) {
    return cents <= maximumCents;
  }

  /// Round to nearest increment (useful for bid increments)
  static int roundToIncrement(int cents, int incrementCents) {
    return ((cents / incrementCents).ceil() * incrementCents);
  }
}
