import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/firebase_providers.dart';

/// Splash screen displayed on app launch
///
/// Performs initialization tasks and navigates to appropriate screen
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();

    // Perform initialization and navigate
    _initialize();
  }

  Future<void> _initialize() async {
    // Simulate initialization tasks (loading cached data, checking version, etc.)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Check authentication status
      final authState = ref.read(authStateStreamProvider);

      authState.when(
        data: (user) {
          if (user != null) {
            // User is authenticated, navigate to home
            context.go(AppConstants.homeRoute);
          } else {
            // User is not authenticated, navigate to login
            context.go(AppConstants.loginRoute);
          }
        },
        error: (_, __) {
          // Error checking auth state, navigate to login
          context.go(AppConstants.loginRoute);
        },
        loading: () {
          // Still loading, wait a bit more
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              context.go(AppConstants.loginRoute);
            }
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Icon/Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.watch,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 32),

                // App Name
                const Text(
                  'Wish Marketplace',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                // Tagline
                Text(
                  'Your Smartwatch Marketplace',
                  style: AppTextStyles.bodyText2.copyWith(
                    color: Colors.white.withValues(alpha:0.9),
                  ),
                ),
                const SizedBox(height: 48),

                // Loading indicator
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
