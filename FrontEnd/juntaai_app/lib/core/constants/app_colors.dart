import 'package:flutter/material.dart';

class AppColors {
  // ======== PRINCIPAIS ========
  static const primary = Color(0xFFEE1162); // Rosa principal (#EE1162)
  static const primarySoft = Color(0x80EE1162); // 50% transparência
  static const background = Color(0xFFFDFDFD); // Fundo geral
  static const surface = Colors.white; // Cartões, campos, etc.
  static const border = Color(0x59D9D9D9); // Bordas sutis (D9D9D959)
  static const shadow = Color(0x33D9D9D9); // Sombras leves (D9D9D933)
  static const onPrimary = Colors.white; // Texto em botões rosa

  // ======== TEXTOS ========
  static const text = Colors.black;
  static const textMuted = Color(0xFF979797);
  static const textHint = Color(0x66000000); // placeholder e ícones input
  static const textDisabled = Color(0xFFCCCCCC);

  // ======== ELEMENTOS DECORATIVOS ========
  static const chip = Color(0xFFFAB7D0);
  static const chipSoft = Color(0x80FAB7D0); // 50%

  // ======== ESTADOS ========
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const error = Color(0xFFD32F2F);

  // ======== EXTRAS ========
  static const navInactive = Color(0xFFC4C4C4); // Navegação desativada
  static const overlay = Color(0x33000000); // 20% preto (para sombras leves)

  // ======== ALIASES PARA COMPATIBILIDADE ========
  static const cardBorder = border; // usa o mesmo #D9D9D959
  static const cardShadow = shadow; // usa o mesmo #D9D9D933
  static const primaryPink = primary; // usa o rosa principal
}
