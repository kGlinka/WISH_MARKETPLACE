import 'package:flutter/material.dart';

/// Reusable button widget for authentication forms
///
/// Provides loading state and consistent styling
class AuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.padding,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ?? theme.colorScheme.primary,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: foregroundColor ?? theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? theme.colorScheme.primary,
                  ),
                ),
              )
            : child,
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.colorScheme.primary,
        foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
        elevation: elevation,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? theme.colorScheme.onPrimary,
                ),
              ),
            )
          : child,
    );
  }
}
