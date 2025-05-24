import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme light = TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black, // For use in AppBar
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
  );
}
