import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

Widget headerHome(BuildContext context) {
  return SizedBox(
    height: 348.h,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(gradient: suratIzinCategory),
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Image.asset('assets/home/dahana-gedung.png'),
        ),
        Positioned(
          top: 100,
          left: 20,
          right: 20,
          child: Image.asset(
            'assets/home/dahana.png',
            height: 100.h,
          ),
        )
      ],
    ),
  );
}
