import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ===== IMPORTAÇÕES DAS TELAS =====
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/register/presentation/cadastro_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/menu/presentation/menu_screen.dart';

// ===== TELAS DE RECUPERAÇÃO =====
import '../../features/auth/presentation/recovery_request_screen.dart';
import '../../features/auth/presentation/recovery_code_screen.dart';
import '../../features/auth/presentation/recovery_reset_screen.dart';

class AppRouter {
  // ===== Transição padrão (slide da direita, 300ms) =====
  static CustomTransitionPage<T> _slideRightPage<T>({required Widget child}) {
    return CustomTransitionPage<T>(
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        final offset = Tween<Offset>(
          begin: const Offset(1, 0), // entra da direita
          end: Offset.zero,
        ).animate(curved);
        return SlideTransition(position: offset, child: child);
      },
    );
  }

  // ===== GoRouter principal do app =====
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (_, __) => const NoTransitionPage(child: SplashScreen()),
      ),

      // Home
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (_, __) => _slideRightPage(child: const HomeScreen()),
      ),

      // Login
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (_, __) => _slideRightPage(child: const LoginScreen()),
      ),

      // Cadastro
      GoRoute(
        path: '/cadastro',
        name: 'cadastro',
        pageBuilder: (_, __) => _slideRightPage(child: const CadastroScreen()),
      ),

      // Dashboard
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (_, __) => _slideRightPage(child: const DashboardScreen()),
      ),

      // ===== NOVA ROTA DO MENU =====
      GoRoute(
        path: '/menu',
        name: 'menu',
        pageBuilder: (_, __) => _slideRightPage(child: const MenuScreen()),
      ),

      // ===== Recuperação de Senha =====
      GoRoute(
        path: '/recovery/request',
        name: 'recovery_request',
        pageBuilder: (_, __) => _slideRightPage(child: const RecoveryRequestScreen()),
      ),
      GoRoute(
        path: '/recovery/code',
        name: 'recovery_code',
        pageBuilder: (_, __) => _slideRightPage(child: const RecoveryCodeScreen()),
      ),
      GoRoute(
        path: '/recovery/reset',
        name: 'recovery_reset',
        pageBuilder: (_, __) => _slideRightPage(child: const RecoveryResetScreen()),
      ),
    ],
    errorBuilder: (_, __) => const Scaffold(body: Center(child: Text('Rota não encontrada'))),
  );
}
