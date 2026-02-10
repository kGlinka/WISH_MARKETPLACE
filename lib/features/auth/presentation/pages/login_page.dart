import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/validators/form_validators.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/social_auth_button.dart';
import '../widgets/password_reset_dialog.dart';

/// Login page
///
/// Provides email/password authentication with password reset functionality
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Perform login
    await ref.read(loginStateProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  void _showPasswordResetDialog() {
    showDialog(
      context: context,
      builder: (context) => PasswordResetDialog(
        initialEmail: _emailController.text.trim(),
      ),
    );
  }

  void _navigateToRegister() {
    context.go(AppConstants.registerRoute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loginState = ref.watch(loginStateProvider);

    // Listen to login state and navigate on success
    ref.listen<AsyncValue<void>>(
      loginStateProvider,
      (previous, next) {
        next.when(
          data: (_) {
            // Success - navigation will be handled by auth state listener
            context.go(AppConstants.homeRoute);
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

    final isLoading = loginState.isLoading;

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
                    'Wish Marketplace',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Sign in to continue',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

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
                    hintText: 'Enter your password',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    enabled: !isLoading,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleLogin(),
                  ),
                  const SizedBox(height: 8),

                  // Remember Me & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Remember Me Checkbox
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remember me',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),

                      // Forgot Password Button
                      TextButton(
                        onPressed: isLoading ? null : _showPasswordResetDialog,
                        child: Text(
                          'Forgot Password?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  AuthButton(
                    onPressed: isLoading ? null : _handleLogin,
                    isLoading: isLoading,
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 24),

                  // Divider with "OR"
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: theme.colorScheme.onSurface.withValues(alpha:0.2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: theme.colorScheme.onSurface.withValues(alpha:0.2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Social Login Buttons (Placeholder for future implementation)
                  SocialAuthButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Google Sign-In coming soon!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                    icon: Icons.g_mobiledata,
                    label: 'Continue with Google',
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                  ),
                  const SizedBox(height: 32),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: isLoading ? null : _navigateToRegister,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign Up',
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
}
