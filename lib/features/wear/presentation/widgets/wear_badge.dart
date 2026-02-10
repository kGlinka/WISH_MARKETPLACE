import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Badge component for displaying counts (notifications, bids)
class WearBadge extends StatelessWidget {
  final int count;
  final Color? backgroundColor;

  const WearBadge({
    super.key,
    required this.count,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? WearColors.error,
        shape: BoxShape.circle,
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
