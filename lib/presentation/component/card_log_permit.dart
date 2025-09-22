import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CardLogPermit extends StatelessWidget {
  final String permitNumber;
  final String permitDescription;

  const CardLogPermit({
    super.key,
    required this.permitDescription,
    required this.permitNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      permitDescription,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      permitNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi',
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Image.asset(
                'assets/icons/documents_icon.png',
                width: 64.w,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
