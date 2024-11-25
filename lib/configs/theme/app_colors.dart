import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xff489FB5);
  static const secondary = Color(0xff16697A);
  static const tertiary = Color(0xff82C0CC);
  static const lightGrey = Color(0xff808080);
  static const whitePage = Color(0xfff9fafe);
}

LinearGradient headerAppBar = const LinearGradient(
  colors: [Color.fromRGBO(180, 222, 231, 1), Color.fromRGBO(129, 213, 229, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient noSuratColor = const LinearGradient(
  colors: [Color.fromRGBO(232, 237, 241, 1), Color.fromRGBO(134, 137, 139, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
