import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Custom error display widget
///
/// Provides consistent error UI across the app
class ErrorDisplay extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryButtonText;

  const ErrorDisplay({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.onRetry,
    this.retryButtonText,
  });

  const ErrorDisplay.network({
    super.key,
    this.message = 'Unable to connect to the network. Please check your internet connection.',
    this.title = 'Network Error',
    this.onRetry,
    this.retryButtonText,
  }) : icon = Icons.wifi_off;

  const ErrorDisplay.server({
    super.key,
    this.message = 'Something went wrong on our end. Please try again later.',
    this.title = 'Server Error',
    this.onRetry,
    this.retryButtonText,
  }) : icon = Icons.cloud_off;

  const ErrorDisplay.notFound({
    super.key,
    this.message = 'The content you are looking for could not be found.',
    this.title = 'Not Found',
    this.onRetry,
    this.retryButtonText,
  }) : icon = Icons.search_off;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: AppTextStyles.headline6.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: AppTextStyles.bodyText2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryButtonText ?? 'Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Compact error message widget
class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorMessage({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.error.withValues(alpha:0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyText2.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 12),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              color: AppColors.error,
            ),
          ],
        ],
      ),
    );
  }
}
