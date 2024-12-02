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
  final bool isEditing;
  final Function(String, String) onFieldChanged;

  const CardDetailSurat(
      {super.key,
      required this.date,
      required this.categorySurat,
      required this.noSurat,
      required this.namaPerusahaan,
      required this.namaDokumen,
      required this.noSuratIzinMabes,
      required this.isEditing,
      required this.onFieldChanged});

  Widget _buildEditableField(String label, String value, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 8.h),
        isEditing
            ? TextField(
                cursorColor: AppColors.primary,
                selectionControls: materialTextSelectionControls,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: AppColors.lightGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 1.5.w)),
                  alignLabelWithHint: false,
                ),
              )
            : Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGrey,
                ),
              ),
        SizedBox(height: 12.h),
      ],
    );
  }

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
          _buildEditableField('Nama Surat', namaDokumen, 'namaDokumen'),
          _buildEditableField('Kategori Surat', categorySurat, 'categorySurat'),
          _buildEditableField('No. Surat', noSurat, 'noSurat'),
          _buildEditableField(
              'Nama Perusahaan', namaPerusahaan, 'namaPerusahaan'),
          _buildEditableField('Tanggal Masuk Berkas', date, 'date'),
          _buildEditableField(
              'No. Surat Izin Mabes', noSuratIzinMabes, 'noSuratIzinMabes'),
        ],
      ),
    );
  }
}
