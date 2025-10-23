import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';
import 'package:juntaai_app/shared/widgets/bottom_nav_item.dart';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 48),
                        Row(
                          children: [
                            SizedBox(width: 30, height: 30, child: SvgPicture.asset('assets/icons/amizade.svg', width: 24, height: 24)),
                            const SizedBox(width: 7),
                            Text('Junta AÍ!', style: AppTypography.titleHome.copyWith(fontSize: 16)),
                            const Spacer(),
                            InkWell(
                              onTap: () => context.pushNamed('menu'),
                              child: SvgPicture.asset('assets/icons/menu.svg', width: 24, height: 24, colorFilter: const ColorFilter.mode(AppColors.text, BlendMode.srcIn)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Text('Olá, Seja bem-vinda!', style: AppTypography.loginTitle.copyWith(fontSize: 14)),
                        const SizedBox(height: 6),
                        Text('Aqui nós buscamos respeito e proteção para todas as mulheres.', style: AppTypography.loginSubtitle.copyWith(fontSize: 12, color: AppColors.textHint)),
                        const SizedBox(height: 48),
                        Text('Escolha uma opção', style: AppTypography.loginTitle.copyWith(fontSize: 13)),
                        const SizedBox(height: 14),

                        // ===== GRID DE OPÇÕES =====
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final max = constraints.maxWidth;
                            const gap = 11.0;
                            final cardW = (max - gap) / 2;
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

                        // ===== CARD LARGO =====
                        const SizedBox(height: 22),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 292,
                            child: const _CardWide(title: 'Responder questionário', chipColor: AppColors.chipSoft, imagePath: 'assets/images/perguntando.png'),
                          ),
                        ),

                        // ===== TEXTO INFORMATIVO =====
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

                  const SizedBox(height: 24),

                  // ===== BARRA DE NAVEGAÇÃO GLOBAL =====
                  BottomNavBar(current: BottomTab.home, onHome: () => context.pushNamed('dashboard'), onDenuncia: () {}, onConteudo: () {}, onApoio: () {}, onEmergency: () {}),

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

/* ---------------------------- CARD PEQUENO ---------------------------- */
class _CardSmall extends StatelessWidget {
  const _CardSmall({required this.title, required this.chipColor, required this.imagePath, required this.width});

  final String title;
  final Color chipColor;
  final String imagePath;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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

/* ---------------------------- CARD LARGO ---------------------------- */
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
