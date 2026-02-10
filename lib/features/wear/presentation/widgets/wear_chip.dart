import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';

/// Chip button optimized for Wear OS with minimum 48dp touch target
class WearChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool enabled;
  final Widget? trailing;

  const WearChip({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.backgroundColor,
    this.labelColor,
    this.enabled = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? WearColors.surface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: enabled ? bgColor : bgColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: WearConstants.minTouchTarget,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: labelColor ?? WearColors.onSurface),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: labelColor ?? WearColors.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
