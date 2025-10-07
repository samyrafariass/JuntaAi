import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:juntaai_app/shared/widgets/primary_text_field.dart';
import 'package:juntaai_app/shared/widgets/primary_button.dart';
import 'package:juntaai_app/core/typography.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeCtrl = TextEditingController();
  final _idadeCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _enderecoCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();

  bool _agree = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _idadeCtrl.dispose();
    _cepCtrl.dispose();
    _enderecoCtrl.dispose();
    _telCtrl.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
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
            constraints: const BoxConstraints(maxWidth: 390, maxHeight: 1467),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24), // base 24
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== HEADER =====
                    // top:61 | left real:36 (24 base + 12)
                    Padding(
                      padding: const EdgeInsets.only(top: 61, left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => context.goNamed('login'),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
                          ),
                          Text('Cadastro', style: AppTypography.pageTitle),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),

                    // ===== ILUSTRAÇÃO =====
                    // image top:106 → header 61 + ~20 = 81 → 106-81 = 25
                    const SizedBox(height: 25),
                    Center(child: Image.asset('assets/images/cadastro_image.png', width: 172, height: 172, fit: BoxFit.contain)),

                    // ===== "Bem-vinda!" =====
                    // top:298 → (106+172=278) → 298-278 = 20
                    const SizedBox(height: 20),
                    Center(child: Text('Bem-vinda!', style: AppTypography.loginTitle)),

                    // ===== parágrafo =====
                    // top:337 → (298+26=324) → 337-324 = 13
                    const SizedBox(height: 13),
                    Center(
                      child: SizedBox(
                        width: 311,
                        child: Text(
                          'Participe da nossa rede de apoio, combatendo e encerrando o ciclo de violência contra a mulher!',
                          textAlign: TextAlign.center,
                          style: AppTypography.loginSubtitle, // 13 / #979797
                        ),
                      ),
                    ),

                    // ===== NOME =====
                    // label top:441 → (337+60=397) → 441-397 = 44
                    const SizedBox(height: 44),
                    // left:47 → base 24 + extra 23
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Nome',
                          hintText: 'Digite seu nome',
                          controller: _nomeCtrl,
                          icon: const Icon(Icons.person_outline, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6, // cadastro usa gap 6px
                        ),
                      ),
                    ),

                    // ===== IDADE =====
                    // label top:537 → (465+50=515) → 537-515 = 22
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Idade',
                          hintText: 'Digite sua idade',
                          controller: _idadeCtrl,
                          icon: const Icon(Icons.cake_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6,
                        ),
                      ),
                    ),

                    // ===== CEP =====
                    // label top:633 → (561+50=611) → 633-611 = 22
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'CEP',
                          hintText: 'Digite seu CEP',
                          controller: _cepCtrl,
                          icon: const Icon(Icons.place_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6,
                        ),
                      ),
                    ),

                    // ===== ENDEREÇO =====
                    // label top:729 → (657+50=707) → 729-707 = 22
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Endereço',
                          hintText: 'Digite seu endereço',
                          controller: _enderecoCtrl,
                          icon: const Icon(Icons.home_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6,
                        ),
                      ),
                    ),

                    // ===== TELEFONE =====
                    // label top:828 → (754+50=804) → 828-804 = 24
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Telefone',
                          hintText: '(DDD) 9 1234 - 5678',
                          controller: _telCtrl,
                          icon: const Icon(Icons.phone_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6,
                        ),
                      ),
                    ),

                    // ===== EMAIL =====
                    // label top:927 → (853+50=903) → 927-903 = 24
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Email',
                          hintText: 'nome@gmail.com',
                          controller: _emailCtrl,
                          icon: const Icon(Icons.email_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6,
                        ),
                      ),
                    ),

                    // ===== SENHA =====
                    // label top:1026 → (952+50=1002) → 1026-1002 = 24
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryTextField(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          controller: _senhaCtrl,
                          isPassword: true,
                          icon: const Icon(Icons.key_outlined, size: 20, color: Color(0x66000000)),
                          labelStyle: AppTypography.fieldLabel,
                          hintStyle: AppTypography.hint,
                          labelGap: 6,
                        ),
                      ),
                    ),

                    // ===== REGRAS DA SENHA =====
                    // primeiro item top:1115 → (1049+50=1099) → 1115-1099 = 16
                    const SizedBox(height: 16),
                    // esquerda 64 (base 24 → extra 40)
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Coluna esquerda
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _RuleDot(text: 'Mínino 8 caracteres'),
                              SizedBox(height: 9), // 21 entre linhas - 12 de altura
                              _RuleDot(text: 'Uma letra maiúscula'),
                              SizedBox(height: 9),
                              _RuleDot(text: 'Uma letra minúscula'),
                            ],
                          ),
                          const Spacer(),
                          // Coluna direita
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _RuleDot(text: 'Um número'),
                              SizedBox(height: 9),
                              _RuleDot(text: 'Um caracter especial'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ===== TERMOS =====
                    // título top:1207 → último item ~ 1157+12=1169 → 1207-1169 = 38
                    const SizedBox(height: 38),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: Row(
                        children: [
                          Text('Termos de uso e privacidade', style: AppTypography.loginTitle.copyWith(fontSize: 13)),
                          const SizedBox(width: 4),
                          const Text('*', style: TextStyle(color: Color(0xFFEE1162), fontSize: 13)),
                        ],
                      ),
                    ),

                    // checkbox linha: top:1250 → (1207+20=1227) → 1250-1227 = 23
                    const SizedBox(height: 23),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _agree,
                              onChanged: (v) => setState(() => _agree = v ?? false),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              side: const BorderSide(color: Colors.black, width: 1),
                              activeColor: pink,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'Eu concordo com os ',
                                style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, height: 1.0, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'termos de uso e privacidade',
                                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, height: 1.0, color: Colors.black, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // parágrafo LGPD: top:1285 → checkbox ~ 1250+15=1265 → 1285-1265 = 20
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 23, right: 23),
                      child: Text.rich(
                        TextSpan(
                          text: 'O tratamento e o armazenamento dos dados seguem o padrão da ',
                          style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, height: 1.2, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'LGPD (Lei n° 13.709/2018)',
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, height: 1.2, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // BOTÃO "Cadastrar": top:1357 → (1285+30=1315) → 1357-1315 = 42
                    const SizedBox(height: 42),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: SizedBox(
                        width: 303,
                        child: PrimaryButton(
                          label: 'Cadastrar',
                          onPressed: _agree ? () {} : null, // desabilita se não concordou
                          height: 50,
                          backgroundColor: pink,
                          borderRadius: 5,
                        ),
                      ),
                    ),

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

// • bolinha + texto (10px) para as regras
class _RuleDot extends StatelessWidget {
  const _RuleDot({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(color: Color(0xFFEE1162), shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins', // mantendo consistência do app
            fontSize: 10,
            height: 1.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
