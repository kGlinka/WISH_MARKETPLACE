import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Progress bar widget for Wear OS
class WearProgressBar extends StatelessWidget {
  final int progress;

  const WearProgressBar({super.key, required this.progress});

  Color get _progressColor {
    if (progress >= 75) return WearColors.success;
    if (progress >= 50) return WearColors.info;
    if (progress >= 25) return WearColors.warning;
    return WearColors.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(fontSize: 10, color: WearColors.onSurfaceVariant),
            ),
            Text(
              '$progress%',
              style: TextStyle(fontSize: 10, color: WearColors.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: SizedBox(
            height: 4,
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: WearColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
            ),
          ),
        ),
      ],
    );
  }
}
