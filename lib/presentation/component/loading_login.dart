import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class LoadingLogin extends StatelessWidget {
  const LoadingLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whitePage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/home/dahana-hitam.png',
            height: 100.h,
          ),
          SizedBox(
            height: 50.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20.w,
            ),
            width: 300.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.whitePage,
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
