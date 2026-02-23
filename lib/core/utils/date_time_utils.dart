import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Utility class for date and time operations
class DateTimeUtils {
  DateTimeUtils._();

  /// Format DateTime to display format (e.g., "Jan 09, 2026")
  static String formatDisplayDate(DateTime dateTime) {
    return DateFormat(AppConstants.displayDateFormat).format(dateTime);
  }

  /// Format DateTime to display format with time (e.g., "Jan 09, 2026 14:30")
  static String formatDisplayDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.displayDateTimeFormat).format(dateTime);
  }

  /// Format DateTime to ISO 8601 string
  static String formatIso(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  /// Parse ISO 8601 string to DateTime
  static DateTime? parseIso(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Get relative time string (e.g., "2 hours ago", "just now")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  /// Format duration to countdown string (e.g., "2d 3h 45m")
  static String formatCountdown(Duration duration) {
    if (duration.isNegative) return 'Expired';

    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  /// Get time until a specific DateTime
  static Duration timeUntil(DateTime dateTime) {
    return dateTime.difference(DateTime.now());
  }

  /// Get time since a specific DateTime
  static Duration timeSince(DateTime dateTime) {
    return DateTime.now().difference(dateTime);
  }

  /// Check if DateTime is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if DateTime is yesterday
  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Check if DateTime is within the last N days
  static bool isWithinDays(DateTime dateTime, int days) {
    final difference = DateTime.now().difference(dateTime);
    return difference.inDays <= days && difference.inDays >= 0;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
  }

  /// Add business days (skipping weekends)
  static DateTime addBusinessDays(DateTime dateTime, int days) {
    var result = dateTime;
    var addedDays = 0;

    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      if (result.weekday != DateTime.saturday &&
          result.weekday != DateTime.sunday) {
        addedDays++;
      }
    }

    return result;
  }

  /// Format time of day
  static String formatTimeOfDay(DateTime dateTime) {
    return DateFormat(AppConstants.timeFormat).format(dateTime);
  }

  /// Check if date is in the future
  static bool isFuture(DateTime dateTime) {
    return dateTime.isAfter(DateTime.now());
  }

  /// Check if date is in the past
  static bool isPast(DateTime dateTime) {
    return dateTime.isBefore(DateTime.now());
  }
}
