import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_loading.dart';

class WearLoginPage extends ConsumerStatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onNavigateToRegister;

  const WearLoginPage({
    super.key,
    required this.onLoginSuccess,
    required this.onNavigateToRegister,
  });

  @override
  ConsumerState<WearLoginPage> createState() => _WearLoginPageState();
}

class _WearLoginPageState extends ConsumerState<WearLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithEmail(
        email: email,
        password: password,
      );
      widget.onLoginSuccess();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const WearLoading();

    return WearScaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: WearConstants.listTopPadding,
        ),
        children: [
          // App icon
          const Icon(
            Icons.favorite,
            color: WearColors.primary,
            size: 48,
          ),
          const SizedBox(height: 4),

          // App title
          const Text(
            'Wish Marketplace',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: WearColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Error message
          if (_errorMessage != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: WearColors.error.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 10, color: WearColors.error),
                textAlign: TextAlign.center,
              ),
            ),

          // Email field
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: const TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
              filled: true,
              fillColor: WearColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.email, size: 16, color: WearColors.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 8),

          // Password field
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(fontSize: 12, color: WearColors.onSurface),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
              filled: true,
              fillColor: WearColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.lock, size: 16, color: WearColors.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 12),

          // Login button
          SizedBox(
            height: WearConstants.minTouchTarget,
            child: ElevatedButton.icon(
              onPressed: _login,
              icon: const Icon(Icons.login, size: 18),
              label: const Text('Login', style: TextStyle(fontSize: 13)),
              style: ElevatedButton.styleFrom(
                backgroundColor: WearColors.primary,
                foregroundColor: WearColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Register button
          SizedBox(
            height: WearConstants.minTouchTarget,
            child: OutlinedButton.icon(
              onPressed: widget.onNavigateToRegister,
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text('Register', style: TextStyle(fontSize: 13)),
              style: OutlinedButton.styleFrom(
                foregroundColor: WearColors.primary,
                side: const BorderSide(color: WearColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
