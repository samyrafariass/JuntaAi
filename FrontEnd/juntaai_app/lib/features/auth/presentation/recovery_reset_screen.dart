import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';

class RecoveryResetScreen extends StatefulWidget {
  const RecoveryResetScreen({super.key});

  @override
  State<RecoveryResetScreen> createState() => _RecoveryResetScreenState();
}

class _RecoveryResetScreenState extends State<RecoveryResetScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  static const _grey66 = Color(0x66000000);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onFieldChanged);
    _confirmController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {}); // atualiza a tela quando o texto muda

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  InputBorder get _inputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.black, width: 1),
  );

  Widget get _prefixKeyIcon => Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: SizedBox(
      width: 20,
      height: 20,
      child: const Center(child: Icon(Icons.key_rounded, size: 18, color: _grey66)),
    ),
  );

  Widget _suffixVisibility({required bool obscured, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 20,
        height: 20,
        child: Center(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Icon(obscured ? Icons.visibility_off : Icons.visibility, size: 17.5, color: _grey66),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 390, maxHeight: 844),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: [
              // Voltar
              Positioned(
                top: 57,
                left: 33,
                width: 20,
                height: 20,
                child: GestureDetector(
                  onTap: () => context.goNamed('recovery_code'),
                  child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
                ),
              ),

              // Título
              Positioned(
                top: 119,
                left: 37,
                width: 170,
                height: 23,
                child: Text(
                  'Criar uma nova senha',
                  style: AppTypography.pageTitle.copyWith(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
                ),
              ),

              // Subtítulo
              Positioned(
                top: 161,
                left: 37,
                width: 294,
                height: 40,
                child: Text('Crie uma nova senha para sua conta. Ela precisa ser diferente da anterior', style: AppTypography.loginSubtitle.copyWith(fontSize: 13, color: Colors.black)),
              ),

              // Label Senha
              Positioned(
                top: 236,
                left: 37,
                child: Text('Senha', style: AppTypography.fieldLabel.copyWith(fontSize: 12, color: Colors.black)),
              ),

              // Campo Senha
              Positioned(
                top: 266,
                left: 37,
                width: 303,
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                    prefixIconConstraints: const BoxConstraints(minWidth: 44),
                    prefixIcon: _prefixKeyIcon,
                    suffixIconConstraints: const BoxConstraints(minWidth: 44),
                    suffixIcon: _suffixVisibility(obscured: _obscurePassword, onTap: () => setState(() => _obscurePassword = !_obscurePassword)),
                    border: _inputBorder,
                    enabledBorder: _inputBorder,
                    focusedBorder: _inputBorder,
                  ),
                ),
              ),

              // Placeholder "Digite sua nova senha"
              if (_passwordController.text.isEmpty)
                Positioned(
                  top: 284,
                  left: 85,
                  width: 200,
                  height: 15,
                  child: IgnorePointer(
                    child: Text('Digite sua nova senha', style: AppTypography.hint.copyWith(fontSize: 10, color: const Color(0x66000000))),
                  ),
                ),

              // Label Confirmar senha
              Positioned(
                top: 352,
                left: 37,
                child: Text('Confirme sua senha', style: AppTypography.fieldLabel.copyWith(fontSize: 12, color: Colors.black)),
              ),

              // Campo Confirmar senha
              Positioned(
                top: 382,
                left: 37,
                width: 303,
                height: 50,
                child: TextField(
                  controller: _confirmController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                    prefixIconConstraints: const BoxConstraints(minWidth: 44),
                    prefixIcon: _prefixKeyIcon,
                    suffixIconConstraints: const BoxConstraints(minWidth: 44),
                    suffixIcon: _suffixVisibility(obscured: _obscureConfirm, onTap: () => setState(() => _obscureConfirm = !_obscureConfirm)),
                    border: _inputBorder,
                    enabledBorder: _inputBorder,
                    focusedBorder: _inputBorder,
                  ),
                ),
              ),

              // Placeholder "Digite sua nova senha novamente"
              if (_confirmController.text.isEmpty)
                Positioned(
                  top: 400,
                  left: 85,
                  width: 240,
                  height: 15,
                  child: IgnorePointer(
                    child: Text('Digite sua nova senha novamente', style: AppTypography.hint.copyWith(fontSize: 10, color: const Color(0x66000000))),
                  ),
                ),

              // Botão
              Positioned(
                top: 722,
                left: 44,
                width: 303,
                height: 50,
                child: SizedBox(
                  width: 303,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => context.goNamed('login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      elevation: 0,
                    ),
                    child: Text('Redefinir senha', style: AppTypography.buttonPrimary.copyWith(fontSize: 14)),
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
