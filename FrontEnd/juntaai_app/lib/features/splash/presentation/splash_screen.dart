import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 320));
    final curved = CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic);
    _fade = Tween<double>(begin: 1, end: 0).animate(curved);
    _scale = Tween<double>(begin: 1.0, end: 0.98).animate(curved);

    // Mostra o splash ~1.4s, anima e navega para a Home
    _timer = Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      _ac.forward().whenComplete(() {
        if (!mounted) return;
        context.goNamed('home');
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Image.asset('assets/images/calendario.png', width: 120, height: 120, errorBuilder: (_, __, ___) => const Icon(Icons.favorite_border, size: 96, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
