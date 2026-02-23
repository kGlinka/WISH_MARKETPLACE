import 'package:flutter/material.dart';
import '../../core/wear_theme.dart';

/// Scaffold optimized for Wear OS with AMOLED black background
class WearScaffold extends StatelessWidget {
  final Widget body;

  const WearScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WearColors.background,
      body: SafeArea(child: body),
    );
  }
}
