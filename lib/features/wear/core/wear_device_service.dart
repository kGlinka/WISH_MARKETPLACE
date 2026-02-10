import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Detects whether the app is running on a Wear OS device
class WearDeviceService {
  /// Check if current device is Wear OS based on screen size and platform
  static bool isWearOS(BuildContext context) {
    if (!Platform.isAndroid) return false;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide <= 300;
  }
}

/// Provider that indicates if the app is running on Wear OS.
/// Must be overridden at the MaterialApp level after MediaQuery is available.
final isWearOSProvider = StateProvider<bool>((ref) => false);
