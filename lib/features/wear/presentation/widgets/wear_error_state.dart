import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Error state widget for Wear OS
class WearErrorState extends StatelessWidget {
  final String message;

  const WearErrorState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearColors.background,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 48, color: WearColors.error),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: WearColors.error),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
