import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 390,
              height: 844,
              color: AppColors.surface,
              child: Stack(
                children: [
                  // ===== Botão Fechar =====
                  Positioned(
                    left: 32,
                    top: 58,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close, size: 24, color: AppColors.closeIcon),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  ),

                  // ===== Título =====
                  Positioned(
                    top: 58,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        height: 23,
                        child: Text('Menu', style: AppTypography.menuTitle, textAlign: TextAlign.center),
                      ),
                    ),
                  ),

                  // ===== Itens do Menu =====
                  _MenuRow(
                    rectColor: AppColors.pinkOverlay,
                    iconWidget: const Icon(Icons.person_outline, size: 18, color: AppColors.pinkStrong),
                    label: 'Perfil',
                    rectTop: 156,
                    arrowTop: 164,
                    onTap: () {},
                  ),

                  _MenuRow(
                    rectColor: AppColors.pinkOverlay,
                    iconWidget: SvgPicture.asset('assets/icons/emergencymenu.svg', width: 18, height: 18, colorFilter: const ColorFilter.mode(AppColors.pinkStrong, BlendMode.srcIn)),
                    label: 'Canais de denúncia',
                    rectTop: 260,
                    arrowTop: 269,
                    onTap: () {},
                  ),

                  _MenuRow(
                    rectColor: AppColors.pinkOverlay,
                    iconWidget: const Icon(Icons.favorite_border, size: 18, color: AppColors.pinkStrong),
                    label: 'Redes de Apoio',
                    rectTop: 364,
                    arrowTop: 373,
                    onTap: () {},
                  ),

                  _MenuRow(
                    rectColor: AppColors.pinkOverlay,
                    iconWidget: const Icon(Icons.shield_outlined, size: 18, color: AppColors.pinkStrong),
                    label: 'Medidas protetivas',
                    rectTop: 476,
                    arrowTop: 492,
                    onTap: () {},
                  ),

                  // ===== Botão SAIR (leva para Home) =====
                  _MenuRow(
                    rectColor: AppColors.redOverlay,
                    iconWidget: const Icon(Icons.logout, size: 18, color: AppColors.redStrong),
                    label: 'Sair',
                    rectTop: 588,
                    isLogout: true,
                    onTap: () => context.goNamed('home'),
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

/* ---------------------------- ITEM DO MENU ---------------------------- */
class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.rectColor, required this.iconWidget, required this.label, required this.rectTop, required this.onTap, this.arrowTop, this.isLogout = false});

  final Color rectColor;
  final Widget iconWidget;
  final String label;
  final double rectTop;
  final double? arrowTop;
  final bool isLogout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = isLogout ? AppTypography.menuItemBold : AppTypography.menuItem;

    return Positioned(
      top: rectTop,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 49,
        child: Stack(
          children: [
            // Retângulo 40x37
            Positioned(
              left: 36,
              top: 0,
              child: Container(
                width: 40,
                height: 37,
                decoration: BoxDecoration(color: rectColor, borderRadius: BorderRadius.circular(5)),
                child: Center(child: iconWidget),
              ),
            ),
            // Label
            Positioned(left: 102, top: 9, child: Text(label, style: textStyle)),
            // Seta 24x24
            if (arrowTop != null)
              Positioned(
                left: 335,
                top: arrowTop! - rectTop,
                child: GestureDetector(
                  onTap: onTap,
                  child: const Icon(Icons.chevron_right_rounded, size: 24, color: AppColors.grayArrow),
                ),
              ),
            // Área clicável total
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
