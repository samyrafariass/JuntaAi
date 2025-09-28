import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../../features/home/presentation/home_screen.dart';

class AppRouter {
  // Exponha um único GoRouter para o app inteiro
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (_, __) => const NoTransitionPage(child: SplashScreen()),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
            final offset = Tween<Offset>(
              begin: const Offset(1, 0), // slide da direita
              end: Offset.zero,
            ).animate(curved);
            return SlideTransition(position: offset, child: child);
          },
        ),
      ),
    ],
    errorBuilder: (_, __) => const Scaffold(body: Center(child: Text('Rota não encontrada'))),
  );
}
