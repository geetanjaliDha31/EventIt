import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingTheme {
  static const Color whiteColor = Color(0xffffffff);

  static TextStyle appText({
    required double size,
    required FontWeight weight,
    Color color = whiteColor,
  }) {
    return GoogleFonts.cinzelDecorative(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
