import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class TitleAuth extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback fun;

  const TitleAuth(
      {super.key,
      required this.secondText,
      required this.firstText,
      required this.fun});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: fun,
        child: Text.rich(
          TextSpan(
            text: firstText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
            children: [
              TextSpan(
                text: secondText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Satoshi',
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
