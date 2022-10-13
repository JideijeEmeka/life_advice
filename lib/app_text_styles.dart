import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle normalTextStyle({required Color color}) {
    return TextStyle(
        fontSize: 17, color: color
    );
  }
  static TextStyle adviceTextStyle = const TextStyle(
    fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold
  );
}