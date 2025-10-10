import 'package:flutter/material.dart';
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
    for (final c in _ctrs) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onChangedBox(int i, String v) {
    if (v.length == 1 && i < _len - 1) {
      _nodes[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
  }

  Widget _codeBox(int i) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: _ctrs[i],
        focusNode: _nodes[i],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
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
      backgroundColor: Colors.white, // frame 390x844 dentro do container
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 390, maxHeight: 844),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              // “left” do layout = 41px
              padding: const EdgeInsets.symmetric(horizontal: 41),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Arrow back — top: 59, left: 41
                  const SizedBox(height: 59),
                  GestureDetector(
                    onTap: () => context.goNamed('recovery_request'),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
                  ),

                  // Espaço entre seta (20px de altura) e o retângulo (target top: 131)
                  const SizedBox(height: 52),

                  // Retângulo com ícone — 113x100, radius 20, #FAB7D0 @ 20%
                  Center(
                    child: Container(
                      width: 113,
                      height: 100,
                      decoration: BoxDecoration(color: const Color(0x33FAB7D0), borderRadius: BorderRadius.circular(20)),
                      child: const Center(child: Icon(Icons.mail_outline_rounded, size: 45, color: AppColors.primary)),
                    ),
                  ),

                  // Título “Cheque seu Email!” — target top: 260
                  const SizedBox(height: 29),
                  Center(
                    child: Text(
                      'Cheque seu Email!',
                      style: AppTypography.loginTitle.copyWith(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),

                  // Descrição — target top: 305, caixa 304x60
                  const SizedBox(height: 22),
                  const Center(
                    child: SizedBox(
                      width: 304,
                      child: Text(
                        'Digite o código de verificação enviado para seu email e siga as instruções para recuperar sua senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 13, height: 1.0, letterSpacing: 0, color: Colors.black),
                      ),
                    ),
                  ),

                  // Caixas do código — target top: 414
                  const SizedBox(height: 49),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(_len, _codeBox)),

                  // “Não recebeu...” — target top: 514
                  const SizedBox(height: 50),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, height: 1.0, color: Colors.black),
                        children: [
                          const TextSpan(text: 'Não recebeu o código? '),
                          TextSpan(
                            text: 'Enviar novamente',
                            style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 12, height: 1.0, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
