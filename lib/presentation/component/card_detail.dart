import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/permit/upload/upload_bloc.dart';

class CardDetailSurat extends StatefulWidget {
  final String date;
  final String categorySurat;
  final String noSurat;
  final String namaPerusahaan;
  final String namaDokumen;
  final String noSuratIzinMabes;
  final String processStatus;
  final String id;

  const CardDetailSurat(
      {super.key,
      required this.date,
      required this.categorySurat,
      required this.noSurat,
      required this.namaPerusahaan,
      required this.namaDokumen,
      required this.noSuratIzinMabes,
      required this.id,
      required this.processStatus});

  @override
  State<CardDetailSurat> createState() => _CardDetailSuratState();
}

class _CardDetailSuratState extends State<CardDetailSurat> {

  @override
  Widget build(BuildContext context) {
    final String typeStatus;
    final TextStyle fontStatusStyle;
    if (widget.processStatus == 'Draft Created') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFD3D3D3),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Draft Created';
    } else if (widget.processStatus == 'Archiving') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFA9A9A9),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Archiving';
    } else if (widget.processStatus == 'Submission') {
      fontStatusStyle = TextStyle(
        color: Color(0xFF007BFF),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Submission';
    } else if (widget.processStatus == 'Verification') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFFFFF00),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Verification';
    } else if (widget.processStatus == 'Initial Approval') {
      fontStatusStyle = TextStyle(
        color: Color(0xFF90EE90),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Initial Approval';
    } else if (widget.processStatus == 'Second Approval') {
      fontStatusStyle = TextStyle(
        color: Color(0xFF008000),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Second Approval';
    } else if (widget.processStatus == 'Drafter') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFFFA500),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Drafter';
    } else if (widget.processStatus == 'Final Approval') {
      fontStatusStyle = TextStyle(
        color: Color(0xFF00FF00),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Final Approval';
    } else if (widget.processStatus == 'Printing') {
      fontStatusStyle = TextStyle(
        color: Color(0xFF800080),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Printing';
    } else {
      fontStatusStyle = TextStyle(
        color: Color(0xFFAF4848),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'No Status';
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }
}
