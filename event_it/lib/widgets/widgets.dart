import 'package:flutter/material.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  fillColor: AppTheme.slightBlack,
  prefixIconColor: AppTheme.backgroundColor,
  hintStyle:
      TextStyle(color: AppTheme.whiteColor, fontWeight: FontWeight.normal),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: AppTheme.whiteColor, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: AppTheme.slightBlack,
      width: 1,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: GoogleFonts.poppins(
          fontSize: 14,
        ),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: "Ok",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
