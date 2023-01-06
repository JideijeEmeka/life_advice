import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle normalTextStyle({required Color color}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
          fontSize: 17, color: color
      )
    );
  }
  static TextStyle adviceTextStyle = const TextStyle(
    fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold
  );
}