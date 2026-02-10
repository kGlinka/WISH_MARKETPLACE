import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Loading indicator for Wear OS
class WearLoading extends StatelessWidget {
  const WearLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearColors.background,
      child: const Center(
        child: CircularProgressIndicator(
          color: WearColors.primary,
        ),
      ),
    );
  }
}
