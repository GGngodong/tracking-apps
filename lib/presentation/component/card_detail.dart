import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CardDetailSurat extends StatelessWidget {
  final String date;
  final String categorySurat;
  final String noSurat;
  final String namaPerusahaan;
  final String namaDokumen;
  final String noSuratIzinMabes;

  const CardDetailSurat(
      {super.key,
      required this.date,
      required this.categorySurat,
      required this.noSurat,
      required this.namaPerusahaan,
      required this.namaDokumen,
      required this.noSuratIzinMabes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Surat',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            namaDokumen,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'Kategori Surat',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            categorySurat,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'No. Surat',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            noSurat,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'Nama Perusahaan',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            namaPerusahaan,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'Tanggal Masuk Berkas',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            'No. Surat Izin Mabes',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            noSuratIzinMabes,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
