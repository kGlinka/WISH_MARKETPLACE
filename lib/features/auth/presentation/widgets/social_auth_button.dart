import 'package:flutter/material.dart';

/// Social authentication button widget
///
/// Provides consistent styling for social login buttons (Google, Facebook, etc.)
class SocialAuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;

  const SocialAuthButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black87,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(
          color: theme.colorScheme.onSurface.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: foregroundColor,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
