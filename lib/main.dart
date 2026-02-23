import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/firebase_service.dart';
import 'core/utils/logger.dart';
import 'features/wear/core/wear_theme.dart';
import 'features/wear/presentation/wear_app_shell.dart';

/// Main entry point for the Wish Marketplace Wear OS application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeApp();

  runApp(
    const ProviderScope(
      child: WishMarketplaceApp(),
    ),
  );
}

/// Initialize required services (Firebase + FCM)
Future<void> _initializeApp() async {
  try {
    AppLogger.info('Initializing Wish Marketplace for Wear OS...');

    // Initialize Firebase
    final firebaseService = FirebaseService();
    final firebaseInitialized = await firebaseService.initialize();

    if (!firebaseInitialized) {
      AppLogger.error('Failed to initialize Firebase');
    }

    // Initialize Firebase Cloud Messaging
    if (firebaseInitialized) {
      await firebaseService.initializeFCM();
      await firebaseService.setupMessageHandlers();
    }

    AppLogger.info('App initialization completed successfully');
  } catch (e, stackTrace) {
    AppLogger.error('Failed to initialize app', e, stackTrace);
  }
}

/// Root application widget for Wear OS
class WishMarketplaceApp extends StatelessWidget {
  const WishMarketplaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wish Marketplace',
      debugShowCheckedModeBanner: false,
      theme: WearTheme.theme,
      home: const WearAppShell(),
    );
  }
}
