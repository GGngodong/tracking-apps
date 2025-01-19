import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:tracking_apps/presentation/component/skeleton_loading.dart';

import '../../configs/theme/app_colors.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1A5C5E61),
                spreadRadius: -4,
                blurRadius: 16,
                offset: Offset(0, 12)),
            BoxShadow(
              color: Color(0x0D5C5E61),
              spreadRadius: -2,
              blurRadius: 6,
              offset: Offset(0, 4), // changes position of shadow
            )
          ]),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SkeletonAnimation(
                  borderRadius: BorderRadius.circular(16.r),
                  shimmerColor: Colors.grey,
                  shimmerDuration: 1500,
                  curve: Curves.linear,
                  child: Container(
                    width: 42.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                SkeletonAnimation(
                  borderRadius: BorderRadius.circular(16.r),
                  shimmerColor: Colors.grey,
                  shimmerDuration: 1500,
                  curve: Curves.linear,
                  child: Container(
                    width: 160.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                SkeletonAnimation(
                  borderRadius: BorderRadius.circular(16.r),
                  shimmerColor: Colors.grey,
                  shimmerDuration: 1500,
                  curve: Curves.linear,
                  child: Container(
                    width: 100.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                SkeletonAnimation(
                  borderRadius: BorderRadius.circular(16.r),
                  shimmerColor: Colors.grey,
                  shimmerDuration: 1500,
                  curve: Curves.linear,
                  child: Container(
                    width: 160.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.r),
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            SkeletonLoading(height: 20.h, width: 150.w,),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(
                  const AssetImage('assets/icons/calendar.png'),
                  size: 14.sp,
                  color: AppColors.lightGrey,
                ),
                SizedBox(
                  width: 6.w,
                ),
                SkeletonLoading(height: 12.h, width: 80.w),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            SkeletonLoading(height: 12.h, width: 80.w),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(
                  const AssetImage('assets/icons/document-pdf.png'),
                  size: 14.sp,
                  color: AppColors.lightGrey,
                ),
                SizedBox(
                  width: 6.w,
                ),
                SkeletonLoading(height: 12.h, width: 80.w),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: SkeletonAnimation(
                    borderRadius: BorderRadius.circular(8.r),
                    shimmerColor: Colors.grey,
                    shimmerDuration: 1500,
                    child: Container(
                      width: 186.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 1,
                  child: SkeletonAnimation(
                    borderRadius: BorderRadius.circular(8.r),
                    shimmerColor: Colors.grey,
                    shimmerDuration: 1500,
                    child: Container(

                      width: 186.w,
                      height: 44.h,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
