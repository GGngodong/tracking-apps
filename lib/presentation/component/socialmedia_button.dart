import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/main.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: CircleAvatar(
          radius: 25.r,
          backgroundColor: Colors.grey.shade300,
          child: CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            child: Image.asset('assets/icons/logo-google.png', height: 20.h,)

          ),
        ),
      ),
    );
  }
}
