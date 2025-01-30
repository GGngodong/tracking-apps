import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/presentation/component/skeleton_loading.dart';

class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key});

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
            offset: Offset(0, 12),
          ),
          BoxShadow(
            color: Color(0x0D5C5E61),
            spreadRadius: -2,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SkeletonLoading(
                    height: 20.h,
                    width: 200.w,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
