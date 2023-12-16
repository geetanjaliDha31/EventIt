import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color 
  backgroundColor
  // whiteColor
   = Color(0xff000000);
  static const Color 
  whiteColor 
  // backgroundColor
  = Color(0xffffffff);
  static const Color blueColor = Color(0xFF3849A8);
  static const Color slightBlack = Color(0xFF4D4A4A);
  static const Color greyColor = Color(0xFF686868);
  static const Color interest1 = Color(0xFF52B28A);
  static const Color interest2 = Color(0xFFA04852);
  static const Color interest3 = Color(0xFFD6BD8E);
  static const Color interest4 = Color(0xFFB96F87);
  static const Color interest5 = Color(0xFF5BC46C);
  static const Color interest6 = Color(0xFFBDA369);
  static const Color interest7 = Color(0xFFF2A792);
  static const Color interest8 = Color(0xFF8AE5EB);
  static const Color interest9 = Color(0xFF5C6457);
  static const Color interest10 = Color(0xFFADC15D);

  static TextStyle appText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = whiteColor,
    double letterSpacing = 1.0,
    bool isShadow = false,
  }) {
    return GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        // wordSpacing: 1.4,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static ButtonStyle buttonStyle(
      {double fontSize = 14,
      FontWeight weight = FontWeight.w500,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        textStyle: appText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor)));
  }

  static ButtonStyle buttonStyle2(
      {double fontSize = 10,
      FontWeight weight = FontWeight.w500,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.white}) {
    return ElevatedButton.styleFrom(
        textStyle: appText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor)));
  }

  static ButtonStyle buttonStyle3(
      {double fontSize = 14,
      FontWeight weight = FontWeight.w500,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        textStyle: appText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: borderColor)));
  }
}
