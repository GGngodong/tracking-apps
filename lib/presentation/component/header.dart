import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class Header extends StatelessWidget {
  final String imageBg;
  final String imageFg;
  final double? height, width;
  final double? topFg, leftFg, rightFg, bottomFg;
  final double? topBg, leftBg, rightBg, bottomBg;

  const Header(
      {super.key,
      this.height,
      required this.imageBg,
      required this.imageFg,
      this.width,
      this.topFg,
      this.leftFg,
      this.rightFg,
      this.bottomFg,
      this.topBg,
      this.leftBg,
      this.rightBg,
      this.bottomBg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 220.h,
              decoration: BoxDecoration(gradient: suratIzinCategory),
            ),
          ),
          Positioned(
            top: topBg,
            left: leftBg,
            right: rightBg,
            child: Image.asset(imageBg),
          ),
          Positioned(
            top: topFg,
            left: leftFg,
            right: rightFg,
            child: Image.asset(
              imageFg,
              height: height,
            ),
          )
        ],
      ),
    );
  }
}
