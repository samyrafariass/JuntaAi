import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Título principal: "Junta Aí!"
  static TextStyle titleHome = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0, // line-height 100%
    letterSpacing: 0.0,
    color: Colors.black,
  );

  // Subtítulo: "A comunidade que protege você!"
  static TextStyle subtitleHome = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    height: 1.0, // line-height 100%
    letterSpacing: 0.0,
    color: Colors.black,
  );

  // Botão primário: "Iniciar"
  static TextStyle buttonPrimary = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.0, // line-height 100%
    letterSpacing: 0.0,
    color: Colors.white,
  );
}
