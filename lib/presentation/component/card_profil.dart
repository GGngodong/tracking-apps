import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/ink_effect.dart';

class CardProfile extends StatelessWidget {
  final String role;
  final String email;
  final String userName;

  const CardProfile({
    super.key,
    required this.userName,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final String typeRole;
    final TextStyle fontRoleStyle;
    if (role == 'ADMIN') {
      fontRoleStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeRole = 'ADMIN';
    } else if (role == 'USER') {
      fontRoleStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeRole = 'USER';
    } else {
      fontRoleStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeRole = 'No Role';
    }
    return InkEffect(
      boxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/user-profile.png',
              width: 64.w,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: role == 'ADMIN'
                        ? const Color(0xFFAF4848)
                        : const Color(0xff308c24),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.02),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 5.5, 12, 5.5),
                    child: Row(
                      children: [
                        Text(typeRole, style: fontRoleStyle),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
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
