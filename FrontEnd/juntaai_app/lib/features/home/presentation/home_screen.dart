import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../core/typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 390, maxHeight: 844),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                const SizedBox(height: 54),

                // Ícone coração
                SvgPicture.asset('assets/icons/amizade.svg', width: 39, height: 39, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),

                const SizedBox(height: 8),

                // Texto "Junta Aí!"
                Text('Junta Aí!', textAlign: TextAlign.center, style: AppTypography.titleHome),

                const SizedBox(height: 40),

                // Ilustração central
                SizedBox(width: 295, height: 295, child: Image.asset('assets/images/image_home.png', fit: BoxFit.contain)),

                const SizedBox(height: 36),

                // Subtítulo
                Text('A comunidade que protege você!', textAlign: TextAlign.center, style: AppTypography.subtitleHome),

                const Spacer(),

                // Botão primário
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: PrimaryButton(
                    label: 'Iniciar',
                    onPressed: () {
                      // TODO: próxima rota
                    },
                    width: 271,
                    height: 50,
                    backgroundColor: const Color(0xFFEE1162),
                    borderRadius: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
