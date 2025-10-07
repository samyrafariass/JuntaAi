import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/register/presentation/cadastro_screen.dart'; // ⬅️ nova tela

class AppRouter {
  // Transição padrão: slide da direita (300ms)
  static CustomTransitionPage<T> _slideRightPage<T>({required Widget child}) {
    return CustomTransitionPage<T>(
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        final offset = Tween<Offset>(
          begin: const Offset(1, 0), // entra da direita
          end: Offset.zero,
        ).animate(curved);
        return SlideTransition(position: offset, child: child);
      },
    );
  }

  // Um único GoRouter para o app inteiro
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
        pageBuilder: (_, __) => _slideRightPage(child: const HomeScreen()),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (_, __) => _slideRightPage(child: const LoginScreen()),
      ),
      GoRoute(
        path: '/cadastro',
        name: 'cadastro', // ⬅️ novo nome de rota
        pageBuilder: (_, __) => _slideRightPage(child: const CadastroScreen()),
      ),
    ],
    errorBuilder: (_, __) => const Scaffold(body: Center(child: Text('Rota não encontrada'))),
  );
}
