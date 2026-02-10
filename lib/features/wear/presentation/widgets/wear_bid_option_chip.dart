import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';

/// Chip for bid amount selection on Wear OS
class WearBidOptionChip extends StatelessWidget {
  final String label;
  final int amount;
  final bool enabled;
  final VoidCallback onTap;

  const WearBidOptionChip({
    super.key,
    required this.label,
    required this.amount,
    required this.enabled,
    required this.onTap,
  });

  String get _amountFormatted {
    return '\$${(amount / 100).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: enabled ? WearColors.surface : WearColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            constraints: const BoxConstraints(minHeight: WearConstants.minTouchTarget),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.gavel, size: 20, color: WearColors.onSurface),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 14, color: WearColors.onSurface),
                  ),
                ),
                Text(
                  _amountFormatted,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: WearColors.success,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
