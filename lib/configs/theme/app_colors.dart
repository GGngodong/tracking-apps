import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF003366);
  static const secondary = Color(0xFFEBB01C);
  static const tertiary = Color(0xFFB3CDE0);
  static const accentRed = Color(0xFFD32F2F);
  static const accentGreen = Color(0xFF388E3C);
  static const lightGrey = Color(0xFF808080);
  static const whitePage = Color(0xFFF8F8F8);
}

LinearGradient headerAppBar = const LinearGradient(
  colors: [
    Color(0xFF003366),
    Color(0xFFB3CDE0),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient noSuratColor = const LinearGradient(
  colors: [
    Color(0xFFB3CDE0),
    Color(0xFF003366),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
