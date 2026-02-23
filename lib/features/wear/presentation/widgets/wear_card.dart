import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Card widget with dark background for Wear OS
class WearCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  const WearCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: backgroundColor ?? WearColors.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
