import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class ServerErrorPage extends StatelessWidget {
  const ServerErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dokumen Kosong',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Satoshi',
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: headerAppBar),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.whitePage,
      body: Padding(
        padding: EdgeInsets.only(top: 190.h),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/server_error.png',
              height: 120.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                'Server sedang bermasalah',
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
        ),
      ),
    );
  }
}
