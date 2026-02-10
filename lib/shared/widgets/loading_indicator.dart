import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Custom loading indicator widget
///
/// Provides consistent loading UI across the app
class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final String? message;

  const LoadingIndicator({
    super.key,
    this.size = 40.0,
    this.color,
    this.strokeWidth = 4.0,
    this.message,
  });

  const LoadingIndicator.small({
    super.key,
    this.color,
    this.message,
  })  : size = 24.0,
        strokeWidth = 3.0;

  const LoadingIndicator.large({
    super.key,
    this.color,
    this.message,
  })  : size = 60.0,
        strokeWidth = 5.0;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.primary,
        ),
      ),
    );

    if (message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          indicator,
          const SizedBox(height: 16),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return indicator;
  }
}

/// Full screen loading overlay
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: AppColors.overlay,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: LoadingIndicator(message: message),
              ),
            ),
          ),
      ],
    );
  }
}
