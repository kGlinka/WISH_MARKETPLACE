import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Empty state widget for Wear OS
class WearEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const WearEmptyState({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearColors.background,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: WearColors.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 14, color: WearColors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
