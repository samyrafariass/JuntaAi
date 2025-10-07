import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/shared/widgets/primary_button.dart';
import 'package:juntaai_app/shared/widgets/primary_text_field.dart';
import 'package:juntaai_app/core/typography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pink = Color(0xFFEE1162);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 390, maxHeight: 892),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24), // base: 24
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== HEADER =====
                    // top:56 | left real:34 (24 base + 10) | ícone 20x20
                    Padding(
                      padding: const EdgeInsets.only(top: 56, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => context.goNamed('home'),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
                          ),
                          Text('Login', style: AppTypography.pageTitle),
                          const SizedBox(width: 20), // balanceador
                        ],
                      ),
                    ),

                    // ===== IMAGEM =====
                    // image top:105 → (header top 56 + 20 de altura = 76) → 105 - 76 = 29
                    const SizedBox(height: 29),
                    Center(child: Image.asset('assets/images/login_image.png', width: 172, height: 172, fit: BoxFit.contain)),

                    // ===== TÍTULO =====
                    // title top:289 → (img 105 + 172 = 277) → 289 - 277 = 12
                    const SizedBox(height: 12),
                    Center(child: Text('Bem-vinda(o) de volta!', style: AppTypography.loginTitle)),

                    // ===== SUBTÍTULO =====
                    // subtitle top:327 → (title 289 + 26 = 315) → 327 - 315 = 12
                    const SizedBox(height: 12),
                    Center(child: Text('Sinta-se mais segura e protegida', style: AppTypography.loginSubtitle)),

                    // ===== EMAIL =====
                    // label email top:424 → (subtitle 327 + 20 = 347) → 424 - 347 = 77
                    const SizedBox(height: 77),
                    // left:48 → base padding 24 + extra 24 = 48
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: SizedBox(
                        width: 303, // largura do retângulo do campo
                        child: PrimaryTextField(
                          labelText: 'Email',
                          hintText: 'Digite seu email',
                          controller: _emailCtrl,
                          icon: const Icon(Icons.email_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                        ),
                      ),
                    ),

                    // ===== SENHA =====
                    // label senha top:515 → (email rect termina 450+50=500) → 515 - 500 = 15
                    const SizedBox(height: 15),
                    // left:48 (mesma lógica do email)
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          controller: _passCtrl,
                          isPassword: true,
                          icon: const Icon(Icons.key_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                        ),
                      ),
                    ),

                    // ===== ESQUECEU SUA SENHA =====
                    // top:609 → (senha rect termina 541+50=591) → 609 - 591 = 18
                    const SizedBox(height: 18),
                    // left:220 → queremos uma margem direita real de 34 (390 - (220 + 136 largura aprx) = ~34)
                    // padding base direita é 24 → adiciono +10 pra chegar em 34
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text('Esqueceu sua senha?', style: AppTypography.forgotPassword),
                        ),
                      ),
                    ),

                    // ===== BOTÃO PRIMÁRIO =====
                    // top:684 → (texto esqueceu ~609 + 18 de altura = 627) → 684 - 627 = 57
                    const SizedBox(height: 57),
                    Center(
                      child: PrimaryButton(label: 'Fazer login', onPressed: () {}, width: 271, height: 50, backgroundColor: pink, borderRadius: 5),
                    ),

                    // ===== OUTLINED =====
                    // top:759 → (primário 684 + 50 = 734) → 759 - 734 = 25
                    const SizedBox(height: 25),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(271, 50),
                          side: const BorderSide(color: pink),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Text('Login anônimo', style: AppTypography.buttonOutlined),
                      ),
                    ),

                    // ===== TEXTO FINAL =====
                    // top:833 → (outlined 759 + 50 = 809) → 833 - 809 = 24
                    const SizedBox(height: 24),
                    Center(
                      child: GestureDetector(
                        onTap: () => context.goNamed('cadastro'),
                        child: Text.rich(
                          TextSpan(
                            text: 'Ainda não é cadastrada? ',
                            style: AppTypography.registerBody,
                            children: [TextSpan(text: 'Cadastre-se', style: AppTypography.registerLink)],
                          ),
                        ),
                      ),
                    ),

                    // respiro final
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
