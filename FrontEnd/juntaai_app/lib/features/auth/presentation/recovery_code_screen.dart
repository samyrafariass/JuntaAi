import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/core/constants/app_colors.dart';
import 'package:juntaai_app/core/typography.dart';

class RecoveryCodeScreen extends StatefulWidget {
  const RecoveryCodeScreen({super.key, this.email});
  final String? email;

  @override
  State<RecoveryCodeScreen> createState() => _RecoveryCodeScreenState();
}

class _RecoveryCodeScreenState extends State<RecoveryCodeScreen> {
  final _len = 5;
  late final List<TextEditingController> _ctrs;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _ctrs = List.generate(_len, (_) => TextEditingController());
    _nodes = List.generate(_len, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _ctrs) c.dispose();
    for (final n in _nodes) n.dispose();
    super.dispose();
  }

  void _onChangedBox(int i, String v) {
    // garante apenas 1 caractere no box
    if (v.length > 1) {
      _ctrs[i].text = v.characters.first;
      _ctrs[i].selection = const TextSelection.collapsed(offset: 1);
    }

    // navegação de foco
    if (v.isNotEmpty && i < _len - 1) {
      _nodes[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }

    _checkCompleted();
  }

  void _checkCompleted() {
    final allFilled = _ctrs.every((c) => c.text.trim().length == 1);
    if (allFilled) {
      FocusScope.of(context).unfocus();
      context.goNamed('recovery_reset'); // navega para a tela de redefinição
    }
  }

  Widget _codeBox(int i, {double height = 50}) {
    return SizedBox(
      width: 50,
      height: height,
      child: TextField(
        controller: _ctrs[i],
        focusNode: _nodes[i],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)],
        textInputAction: i == _len - 1 ? TextInputAction.done : TextInputAction.next,
        onSubmitted: (_) => _checkCompleted(),
        style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 18, height: 1.0, color: Colors.black),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFC7C7C7), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFC7C7C7), width: 1),
          ),
        ),
        onChanged: (v) => _onChangedBox(i, v),
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
              // Arrow back
              Positioned(
                top: 59,
                left: 43,
                width: 20,
                height: 20,
                child: GestureDetector(
                  onTap: () => context.goNamed('recovery_request'),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
                ),
              ),

              // Retângulo claro com ícone no centro
              Positioned(
                top: 131,
                left: 138,
                width: 113,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x33FAB7D0), // #FAB7D0 com 20% de opacidade
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.mail, // ícone preenchido
                      size: 45,
                      color: Color(0xFFEE1162), // #EE1162 preenchido
                    ),
                  ),
                ),
              ),

              // Título
              Positioned(
                top: 260,
                left: 124,
                width: 143,
                height: 23,
                child: Text(
                  'Cheque seu Email!',
                  style: AppTypography.loginTitle.copyWith(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),

              // Descrição
              const Positioned(
                top: 305,
                left: 43,
                width: 304,
                height: 60,
                child: Text(
                  'Digite o código de verificação enviado para seu email e siga as instruções para recuperar sua senha',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 13, height: 1.0, color: Colors.black),
                ),
              ),

              // Caixas do código
              Positioned(
                top: 414,
                left: 42,
                right: 42,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _codeBox(0, height: 51),
                    const SizedBox(width: 14),
                    _codeBox(1),
                    const SizedBox(width: 14),
                    _codeBox(2),
                    const SizedBox(width: 14),
                    _codeBox(3),
                    const SizedBox(width: 14),
                    _codeBox(4),
                  ],
                ),
              ),

              // Texto “Não recebeu o código?”
              Positioned(
                top: 514,
                left: 67,
                width: 256,
                height: 18,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12, height: 1.0, color: Colors.black),
                    children: [
                      TextSpan(text: 'Não recebeu o código? '),
                      TextSpan(
                        text: 'Enviar novamente',
                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 12, height: 1.0, color: AppColors.primary),
                      ),
                    ],
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
