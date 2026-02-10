import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';

/// Email verification dialog
///
/// Shown after successful registration to inform user about email verification
class EmailVerificationDialog extends StatelessWidget {
  final String email;

  const EmailVerificationDialog({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.mark_email_unread_outlined,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Verify Your Email',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Illustration
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha:0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.email_outlined,
              size: 64,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),

          // Message
          Text(
            'We\'ve sent a verification email to:',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            email,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha:0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstructionItem(
                  theme,
                  '1. Check your email inbox',
                ),
                const SizedBox(height: 8),
                _buildInstructionItem(
                  theme,
                  '2. Click the verification link',
                ),
                const SizedBox(height: 8),
                _buildInstructionItem(
                  theme,
                  '3. Return to the app and sign in',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Note about spam folder
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha:0.5),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'If you don\'t see the email, check your spam folder',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha:0.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go(AppConstants.loginRoute);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Go to Sign In'),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionItem(ThemeData theme, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          size: 18,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
