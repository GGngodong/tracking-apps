import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/icons/notification_empty.png',
          height: 120.h,
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Text(
            'Tidak ada notifikasi.',
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Satoshi'),
          ),
        ),
        Center(
          child: Text(
            'Silahkan cek kembali nanti',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              fontFamily: 'Satoshi',
            ),
          ),
        ),
      ],
    );
  }
}
