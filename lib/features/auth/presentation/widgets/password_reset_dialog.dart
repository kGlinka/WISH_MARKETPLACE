import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/validators/form_validators.dart';
import '../providers/auth_providers.dart';
import 'auth_text_field.dart';
import 'auth_button.dart';

/// Password reset dialog
///
/// Allows users to request a password reset email
class PasswordResetDialog extends ConsumerStatefulWidget {
  final String? initialEmail;

  const PasswordResetDialog({
    super.key,
    this.initialEmail,
  });

  @override
  ConsumerState<PasswordResetDialog> createState() =>
      _PasswordResetDialogState();
}

class _PasswordResetDialogState extends ConsumerState<PasswordResetDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Send password reset email
    await ref.read(loginStateProvider.notifier).sendPasswordResetEmail(
          _emailController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginStateProvider);

    // Listen to login state for password reset result
    ref.listen<AsyncValue<void>>(
      loginStateProvider,
      (previous, next) {
        next.when(
          data: (_) {
            // Success
            setState(() {
              _emailSent = true;
            });
          },
          error: (error, stackTrace) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          loading: () {},
        );
      },
    );

    final isLoading = loginState.isLoading;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            _emailSent ? Icons.check_circle : Icons.lock_reset,
            color: _emailSent
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _emailSent ? 'Email Sent!' : 'Reset Password',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: _emailSent
          ? _buildSuccessContent(theme)
          : _buildFormContent(theme, isLoading),
      actions: _emailSent
          ? [
              AuthButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ]
          : [
              AuthButton(
                onPressed: () => Navigator.of(context).pop(),
                isOutlined: true,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              AuthButton(
                onPressed: isLoading ? null : _handlePasswordReset,
                isLoading: isLoading,
                child: const Text('Send Email'),
              ),
            ],
      actionsAlignment: MainAxisAlignment.end,
    );
  }

  Widget _buildFormContent(ThemeData theme, bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.7),
            ),
          ),
          const SizedBox(height: 24),
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: FormValidators.validateEmail,
            enabled: !isLoading,
            autofocus: widget.initialEmail == null || widget.initialEmail!.isEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.mark_email_read_outlined,
          size: 64,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Password reset email has been sent to:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha:0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          _emailController.text.trim(),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Please check your email and follow the instructions to reset your password.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha:0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
