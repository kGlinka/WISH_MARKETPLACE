import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_chip.dart';

class WearSettingsPage extends ConsumerStatefulWidget {
  final VoidCallback onSignOut;

  const WearSettingsPage({super.key, required this.onSignOut});

  @override
  ConsumerState<WearSettingsPage> createState() => _WearSettingsPageState();
}

class _WearSettingsPageState extends ConsumerState<WearSettingsPage> {
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: WearColors.surface,
        title: const Text(
          'Sign Out?',
          style: TextStyle(color: WearColors.onSurface),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: WearColors.onSurfaceVariant),
          ),
          IconButton(
            onPressed: () {
              final authService = ref.read(authServiceProvider);
              authService.signOut();
              Navigator.pop(context);
              widget.onSignOut();
            },
            icon: const Icon(Icons.check, color: WearColors.primary),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return WearScaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: WearConstants.listHorizontalPadding,
          vertical: WearConstants.listTopPadding,
        ),
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: WearColors.primary),
              textAlign: TextAlign.center,
            ),
          ),

          // User info card
          WearCard(
            child: Column(
              children: [
                const Icon(Icons.account_circle, size: 48, color: WearColors.primary),
                const SizedBox(height: 8),
                Text(
                  user?.email ?? 'Not logged in',
                  style: const TextStyle(fontSize: 14, color: WearColors.onSurface),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Notifications preference
          WearChip(
            label: 'Notifications',
            icon: Icons.notifications,
            onTap: () {},
          ),

          // Auto-bid settings
          WearChip(
            label: 'Auto-Bid Settings',
            icon: Icons.autorenew,
            onTap: () {},
          ),

          // Display preferences
          WearChip(
            label: 'Display',
            icon: Icons.brightness_6,
            onTap: () {},
          ),

          // Privacy & Security
          WearChip(
            label: 'Privacy & Security',
            icon: Icons.security,
            onTap: () {},
          ),

          // About
          WearChip(
            label: 'About',
            icon: Icons.info,
            onTap: () {},
          ),

          const SizedBox(height: 8),

          // Sign out button
          WearChip(
            label: 'Sign Out',
            icon: Icons.logout,
            backgroundColor: WearColors.error,
            labelColor: Colors.white,
            onTap: _showSignOutDialog,
          ),

          // Version info
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 10, color: WearColors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
