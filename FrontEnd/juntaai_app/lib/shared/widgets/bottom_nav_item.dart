import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';

enum BottomTab { home, denuncia, conteudo, apoio }

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.current, this.onHome, this.onDenuncia, this.onConteudo, this.onApoio, this.onEmergency});

  final BottomTab current;
  final VoidCallback? onHome;
  final VoidCallback? onDenuncia;
  final VoidCallback? onConteudo;
  final VoidCallback? onApoio;
  final VoidCallback? onEmergency;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // ===== Barra inferior =====
        Container(
          width: 390,
          height: 77,
          margin: const EdgeInsets.only(top: 35),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
            boxShadow: [BoxShadow(offset: Offset(0, -4), blurRadius: 10, spreadRadius: 1, color: AppColors.shadow)],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BottomNavItem(icon: Icons.home_outlined, label: 'Home', selected: current == BottomTab.home, onTap: onHome),
                _BottomNavItem(icon: Icons.warning_amber_rounded, label: 'Denúncia', selected: current == BottomTab.denuncia, onTap: onDenuncia),
                const SizedBox(width: 48),
                _BottomNavItem(icon: Icons.info_outline, label: 'Conteúdo', selected: current == BottomTab.conteudo, onTap: onConteudo),
                _BottomNavItem(icon: Icons.favorite_border, label: 'Apoio', selected: current == BottomTab.apoio, onTap: onApoio),
              ],
            ),
          ),
        ),

        // ===== Botão de emergência (central) =====
        GestureDetector(
          onTap: onEmergency,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.chip,
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10)],
            ),
            child: Center(child: SvgPicture.asset('assets/icons/emergency.svg', width: 32, height: 32)),
          ),
        ),
      ],
    );
  }
}

/* ---------------------------- ITEM INDIVIDUAL ---------------------------- */
class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.icon, required this.label, this.selected = false, this.onTap});

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.navInactive;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.buttonOutlined.copyWith(fontSize: 9, color: color, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
