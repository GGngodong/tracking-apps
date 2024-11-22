import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/main.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const HeaderTitle({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey
          ),
        )
      ],
    );
  }
}
