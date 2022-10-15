import 'package:flutter/material.dart';
import 'package:life_advice/app_text_styles.dart';

SnackBar snackBar({required String message}) {
  return SnackBar
    (elevation: 5, padding: const EdgeInsets.all(25),
      margin:  const EdgeInsets.all(25),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.blue, width: 2.5)
      ),
      content: Text(message, style: AppTextStyles.normalTextStyle(
          color: Colors.white),));
}