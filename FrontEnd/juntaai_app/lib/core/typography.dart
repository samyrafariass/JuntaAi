import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // =========================
  // ⚙️ Base configurável
  // =========================
  static TextStyle _base({required double size, FontWeight weight = FontWeight.w400, Color color = Colors.black}) {
    return GoogleFonts.poppins(fontSize: size, fontWeight: weight, height: 1.0, letterSpacing: 0.0, color: color);
  }

  // =========================
  // 🏠 HOME
  // =========================
  static final titleHome = _base(size: 22);
  static final subtitleHome = _base(size: 16);
  static final buttonPrimary = _base(size: 14, weight: FontWeight.w600, color: Colors.white);

  // =========================
  // 🔐 LOGIN
  // =========================
  static final pageTitle = _base(size: 15);
  static final loginTitle = _base(size: 17, weight: FontWeight.w500);
  static final loginSubtitle = _base(size: 13, color: const Color(0xFF979797));

  static final fieldLabel = _base(size: 12);
  static final hint = _base(size: 10, color: const Color(0x66000000));

  static final forgotPassword = _base(size: 12, color: const Color(0xFFEE1162));

  static final buttonOutlined = _base(size: 14, weight: FontWeight.w500, color: const Color(0xFFEE1162));

  static final registerBody = _base(size: 13);
  static final registerLink = _base(size: 13, weight: FontWeight.w500, color: const Color(0xFFEE1162));
}
