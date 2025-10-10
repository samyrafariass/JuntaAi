import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';

class RecoveryRequestScreen extends StatelessWidget {
  const RecoveryRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: [
              // seta voltar
              Positioned(
                top: 63,
                left: 41,
                child: GestureDetector(
                  onTap: () => context.goNamed('login'),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.text),
                ),
              ),

              // título
              Positioned(
                top: 118,
                left: 41,
                child: Text(
                  'Recuperação de senha',
                  style: AppTypography.loginTitle.copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.text),
                ),
              ),

              // subtítulo
              Positioned(
                top: 161,
                left: 41,
                width: 294,
                child: Text('Digite seu email vinculado a sua conta para recuperação de sua senha', style: AppTypography.registerBody.copyWith(fontSize: 13, color: AppColors.text, height: 1.0)),
              ),

              // label
              Positioned(
                top: 236,
                left: 41,
                child: Text('Email', style: AppTypography.fieldLabel.copyWith(fontSize: 12, color: AppColors.text)),
              ),

              // input
              Positioned(
                top: 262,
                left: 41,
                child: Container(
                  width: 303,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.text, width: 1),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.mail_outline, size: 20, color: AppColors.textHint),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          style: AppTypography.fieldLabel.copyWith(fontSize: 10, color: AppColors.text),
                          decoration: InputDecoration(
                            hintText: 'Digite seu email',
                            hintStyle: AppTypography.hint.copyWith(fontSize: 10, color: AppColors.textHint),
                            border: InputBorder.none,
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // botão
              Positioned(
                top: 356,
                left: 41,
                child: GestureDetector(
                  onTap: () {
                    context.goNamed('recovery_code');
                  },
                  child: Container(
                    width: 303,
                    height: 50,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Enviar código de recuperação',
                        style: AppTypography.loginTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onPrimary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
