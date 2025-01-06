import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar noInternet = SnackBar(
  width: 160,
  content: Text(
    'Koneksi internet bermasalah',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 10.sp),
  ),
  behavior: SnackBarBehavior.floating,
);
