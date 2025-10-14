import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 390, maxHeight: 1035),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Área com padding lateral = 27 =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TOPO
                        const SizedBox(height: 48), // levemente menor, como no Figma
                        Row(
                          children: [
                            SizedBox(width: 30, height: 30, child: SvgPicture.asset('assets/icons/amizade.svg', width: 24, height: 24)),
                            const SizedBox(width: 7),
                            Text('Junta AÍ!', style: AppTypography.titleHome.copyWith(fontSize: 16)),
                            const Spacer(),
                            SvgPicture.asset('assets/icons/menu.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppColors.text, BlendMode.srcIn)),
                          ],
                        ),

                        // SAUDAÇÃO
                        const SizedBox(height: 36),
                        Text('Olá, Seja bem-vinda!', style: AppTypography.loginTitle.copyWith(fontSize: 14)),
                        const SizedBox(height: 6),
                        Text('Aqui nós buscamos respeito e proteção para todas as mulheres.', style: AppTypography.loginSubtitle.copyWith(fontSize: 12, color: AppColors.textHint)),

                        // TÍTULO SEÇÃO
                        const SizedBox(height: 48),
                        Text('Escolha uma opção', style: AppTypography.loginTitle.copyWith(fontSize: 13)),

                        // GRID 2×2 responsivo (mesmo alinhamento do Figma)
                        const SizedBox(height: 14),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // largura útil dentro do padding (27px já aplicados)
                            final max = constraints.maxWidth; // ~336px no iPhone 390
                            const gap = 11.0;
                            final cardW = (max - gap) / 2; // preenche as duas colunas com o gap central
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    _CardSmall(width: cardW, title: 'Redes de apoio', chipColor: AppColors.chip, imagePath: 'assets/images/amor_proprio.png'),
                                    const SizedBox(width: gap),
                                    _CardSmall(width: cardW, title: 'Tipos e ciclo da\nviolência', chipColor: AppColors.chip, imagePath: 'assets/images/dedo_indicador.png'),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    _CardSmall(width: cardW, title: 'Denuncie aqui', chipColor: AppColors.chipSoft, imagePath: 'assets/images/denunciante.png'),
                                    const SizedBox(width: gap),
                                    _CardSmall(width: cardW, title: 'Rompendo o ciclo', chipColor: AppColors.chipSoft, imagePath: 'assets/images/flor_de_lotus.png'),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),

                        // CARD LARGO
                        const SizedBox(height: 22),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 292, // mesmo do Figma (mais estreito que a largura útil)
                            child: const _CardWide(title: 'Responder questionário', chipColor: AppColors.chipSoft, imagePath: 'assets/images/perguntando.png'),
                          ),
                        ),

                        // Texto explicativo
                        const SizedBox(height: 22),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: SizedBox(
                            width: 286,
                            child: Text(
                              'Responda o questionário e tenha acesso a redes de apoio e canais de denúncia específicos para sua situação!',
                              style: AppTypography.loginTitle.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== BOTTOM NAV (NÃO FIXO) + BOTÃO CENTRAL =====
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Barra inferior (390×77)
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
                              children: const [
                                _BottomNavItem(icon: Icons.home_outlined, label: 'Home', selected: true),
                                _BottomNavItem(icon: Icons.warning_amber_rounded, label: 'Denúncia'),
                                SizedBox(width: 48),
                                _BottomNavItem(icon: Icons.info_outline, label: 'Conteúdo'),
                                _BottomNavItem(icon: Icons.favorite_border, label: 'Apoio'),
                              ],
                            ),
                          ),
                        ),

                        // Botão de Emergência (SVG central)
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAB7D0), // #FAB7D0 do Figma
                            shape: BoxShape.circle,
                            boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10)],
                          ),
                          child: Center(child: SvgPicture.asset('assets/icons/emergency.svg', width: 32, height: 32)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------------------- SMALL CARD ---------------------------- */
class _CardSmall extends StatelessWidget {
  const _CardSmall({required this.title, required this.chipColor, required this.imagePath, required this.width});

  final String title;
  final Color chipColor;
  final String imagePath;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // <- largura calculada no LayoutBuilder (bate nas 2 colunas)
      height: 135,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.border),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: Offset(0, 1))],
        ),
        child: Column(
          children: [
            const SizedBox(height: 14),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: chipColor, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.hint.copyWith(fontSize: 10, color: AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------- WIDE CARD ---------------------------- */
class _CardWide extends StatelessWidget {
  const _CardWide({required this.title, required this.chipColor, required this.imagePath});

  final String title;
  final Color chipColor;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 103,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.border),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: Offset(0, 1))],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: chipColor, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title, style: AppTypography.hint.copyWith(fontSize: 10, color: AppColors.text)),
            ),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------- NAV ITEM ---------------------------- */
class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.icon, required this.label, this.selected = false});

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.navInactive;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.loginTitle.copyWith(fontSize: 9, fontWeight: FontWeight.w500, color: color),
        ),
      ],
    );
  }
}
