import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CardDetailSurat extends StatefulWidget {
  final String date;
  final String categorySurat;
  final String noSurat;
  final String namaPerusahaan;
  final String namaDokumen;
  final String noSuratIzinMabes;
  final String processStatus;
  final String uploadStatus;
  final String id;
  final String note;

  const CardDetailSurat({
    super.key,
    required this.date,
    required this.categorySurat,
    required this.noSurat,
    required this.namaPerusahaan,
    required this.namaDokumen,
    required this.noSuratIzinMabes,
    required this.id,
    required this.processStatus,
    required this.uploadStatus,
    required this.note,
  });

  @override
  State<CardDetailSurat> createState() => _CardDetailSuratState();
}

class _CardDetailSuratState extends State<CardDetailSurat> {
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
            'Status Permohonan',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            widget.uploadStatus,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Kategori Surat',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.categorySurat,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'No. Surat',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.noSurat,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Nama Perusahaan',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.namaPerusahaan,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Tanggal Masuk Berkas',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.date,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'No. Surat Izin Mabes',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.noSuratIzinMabes,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Status Proses Tahapan',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.processStatus,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Catatan',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.note,
            maxLines: 3,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Satoshi',
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
