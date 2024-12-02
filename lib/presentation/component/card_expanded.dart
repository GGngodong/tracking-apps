import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CardExpanded extends StatefulWidget {
  final String date;
  final String categorySurat;
  final VoidCallback fun;
  final String namaDokumen;
  final String namaPerusahaan;
  final String noSurat;
  final String noSuratIzinMabes;

  const CardExpanded(
      {super.key,
      required this.date,
      required this.categorySurat,
      required this.namaDokumen,
      required this.namaPerusahaan,
      required this.noSurat,
      required this.noSuratIzinMabes,
      required this.fun});

  @override
  State<CardExpanded> createState() => _CardExpandedState();
}

class _CardExpandedState extends State<CardExpanded> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: ExpansionTile(
        title: Text(
          widget.namaDokumen,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: AppColors.primary,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(color: Colors.transparent),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        children: [
          SizedBox(
            height: 10.h,
          ),
          _buildRow('Nama Surat', widget.namaDokumen),
          SizedBox(
            height: 10.h,
          ),
          _buildRow('No. Surat', widget.noSurat),
          SizedBox(
            height: 10.h,
          ),
          _buildRow('Kategori', widget.categorySurat),
          SizedBox(
            height: 10.h,
          ),
          _buildRow('Nama Perusahaan', widget.namaPerusahaan),
          SizedBox(
            height: 10.h,
          ),
          _buildRow('Tanggal Masuk Berkas', widget.date),
          SizedBox(
            height: 10.h,
          ),
          _buildRow('No. Surat Izin Mabes', widget.noSuratIzinMabes),
          SizedBox(
            height: 10.h,
          ),
          _buildRow('Status', widget.namaDokumen),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: widget.fun,
                child: Text(
                  'Lihat Dokumen',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

Widget _buildRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title : ',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightGrey,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}
