import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/validators/form_validators.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/email_verification_dialog.dart';

/// Register page
///
/// Provides user registration with email/password and email verification
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please accept the Terms and Conditions'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Perform registration
    await ref.read(registerStateProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          username: _usernameController.text.trim(),
        );
  }

  void _navigateToLogin() {
    context.go(AppConstants.loginRoute);
  }

  void _showEmailVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EmailVerificationDialog(
        email: _emailController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final registerState = ref.watch(registerStateProvider);

    // Listen to register state and navigate on success
    ref.listen<AsyncValue<void>>(
      registerStateProvider,
      (previous, next) {
        next.when(
          data: (_) {
            // Success - show email verification dialog
            _showEmailVerificationDialog();
          },
          error: (error, stackTrace) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
              ),
            );
          },
          loading: () {},
        );
      },
    );

    final isLoading = registerState.isLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo/Icon
                  Icon(
                    Icons.watch_rounded,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),

                  // App Title
                  Text(
                    'Create Account',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Sign up to get started',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Username Field
                  AuthTextField(
                    controller: _usernameController,
                    label: 'Username',
                    hintText: 'Choose a username',
                    prefixIcon: Icons.person_outline,
                    validator: FormValidators.validateUsername,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  AuthTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: FormValidators.validateEmail,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Create a password',
                    obscureText: _obscurePassword,
                    prefixIcon: Icons.lock_outlined,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: FormValidators.validatePassword,
                    enabled: !isLoading,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}), // Rebuild for strength indicator
                  ),
                  const SizedBox(height: 8),

                  // Password Strength Indicator
                  if (_passwordController.text.isNotEmpty)
                    PasswordStrengthIndicator(
                      password: _passwordController.text,
                    ),
                  const SizedBox(height: 16),

                  // Confirm Password Field
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    obscureText: _obscureConfirmPassword,
                    prefixIcon: Icons.lock_outlined,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) => FormValidators.validatePasswordConfirmation(
                      value,
                      _passwordController.text,
                    ),
                    enabled: !isLoading,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleRegister(),
                  ),
                  const SizedBox(height: 16),

                  // Terms and Conditions Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _acceptTerms,
                          onChanged: isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _acceptTerms = value ?? false;
                                  });
                                },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              'I accept the ',
                              style: theme.textTheme.bodyMedium,
                            ),
                            InkWell(
                              onTap: () {
                                // TODO: Navigate to Terms and Conditions
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Terms and Conditions page coming soon'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Text(
                                'Terms and Conditions',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Register Button
                  AuthButton(
                    onPressed: isLoading ? null : _handleRegister,
                    isLoading: isLoading,
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 24),

                  // Password Requirements Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password Requirements:',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildRequirementItem(
                          theme,
                          'At least 8 characters',
                        ),
                        _buildRequirementItem(
                          theme,
                          'One uppercase letter',
                        ),
                        _buildRequirementItem(
                          theme,
                          'One lowercase letter',
                        ),
                        _buildRequirementItem(
                          theme,
                          'One number',
                        ),
                        _buildRequirementItem(
                          theme,
                          'One special character (!@#\$%^&*)',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: isLoading ? null : _navigateToLogin,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign In',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
