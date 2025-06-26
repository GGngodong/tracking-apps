import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class UserUnauthorized extends StatelessWidget {
  final void Function()? onRetry;

  const UserUnauthorized({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePage,
      body: Padding(
        padding: EdgeInsets.only(top: 190.h),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/user_empty.png',
              height: 120.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                'Unauthorized Access.',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi'),
              ),
            ),
            Center(
              child: Text(
                'Silahkan login kembali atau hubungi admin jika masalah berlanjut',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Satoshi',
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Coba Lagi',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Satoshi',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
