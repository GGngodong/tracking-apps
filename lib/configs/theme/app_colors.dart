import 'package:flutter/material.dart';

// class AppColors {
//   static const primary = Color(0xff489FB5);
//   static const secondary = Color(0xff16697A);
//   static const tertiary = Color(0xff82C0CC);
//   static const lightGrey = Color(0xff808080);
//   static const whitePage = Color(0xfff9fafe);
// }
//
// LinearGradient headerAppBar = const LinearGradient(
//   colors: [Color.fromRGBO(180, 222, 231, 1), Color.fromRGBO(129, 213, 229, 1)],
//   begin: Alignment.centerLeft,
//   end: Alignment.centerRight,
// );
//
// LinearGradient noSuratColor = const LinearGradient(
//   colors: [Color.fromRGBO(232, 237, 241, 1), Color.fromRGBO(134, 137, 139, 1)],
//   begin: Alignment.centerLeft,
//   end: Alignment.centerRight,
// );

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
    Color(0xFF003366), // primary (deep navy) at left
    Color(0xFFB3CDE0), // tertiary (light steel‐blue) at right
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// 2) “No Surat” CARD (light steel‐blue → navy)
LinearGradient noSuratColor = const LinearGradient(
  colors: [
    Color(0xFFB3CDE0), // tertiary (light‐blue) at left
    Color(0xFF003366), // primary (deep navy) at right
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
