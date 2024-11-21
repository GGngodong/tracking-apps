import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/presentation/component/ink_effect.dart';

Widget cardProfile({
  required BuildContext context,
  String name = 'Login',
  String role = '',
  String mail = '',
  String avatar = '',
  bool isLoggedIn = false,
}) {
  return InkEffect(
    boxDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
    ),
    onTap: () {},
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 20.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ),
    ),
  );
}
