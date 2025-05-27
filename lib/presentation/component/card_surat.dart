import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CardSurat extends StatelessWidget {
  final String date;
  final String categorySurat;
  final String noSurat;
  final String namaPerusahaan;
  final String namaDokumen;
  final String noSuratIzinMabes;
  final String uploadStatus;
  final String processStatus;
  final VoidCallback detailSurat;
  final VoidCallback funcRead;
  final VoidCallback funcDownloadPermohonan;
  final VoidCallback funcDownloadSuratTerbit;

  const CardSurat({
    required this.date,
    required this.categorySurat,
    required this.namaDokumen,
    required this.namaPerusahaan,
    required this.noSurat,
    required this.noSuratIzinMabes,
    required this.processStatus,
    required this.funcRead,
    required this.funcDownloadPermohonan,
    required this.funcDownloadSuratTerbit,
    required this.detailSurat,
    required this.uploadStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Color borderUploadColor = const Color(0xFFBDBDBD);
    late String typeUpload;
    late TextStyle fontUploadSyle;
    if (uploadStatus == 'PENDING') {
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      borderUploadColor = const Color(0xFFBDBDBD);
      typeUpload = 'PENDING';
    } else if (uploadStatus == 'APPROVED') {
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      borderUploadColor = const Color(0xFF32A850);
      typeUpload = 'APPROVED';
    } else if (uploadStatus == 'REJECTED') {
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      borderUploadColor = const Color(0xFFAF4848);
      typeUpload = 'REJECTED';
    } else {
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeUpload = 'No Status';
      borderUploadColor = const Color(0xFFBDBDBD);
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A5C5E61),
              spreadRadius: -4,
              blurRadius: 16,
              offset: Offset(0, 12)),
          BoxShadow(
            color: Color(0x0D5C5E61),
            spreadRadius: -2,
            blurRadius: 6,
            offset: Offset(0, 4), // changes position of shadow
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.tertiary),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Text(
                      noSurat,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: borderUploadColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Text(
                      typeUpload,
                      style: fontUploadSyle,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(
              height: 12.h,
            ),
            GestureDetector(
              onTap: detailSurat,
              child: Text(
                namaDokumen,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Satoshi',
                  fontSize: 18.sp,
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(
                  const AssetImage('assets/icons/calendar.png'),
                  size: 14.sp,
                  color: AppColors.lightGrey,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              namaPerusahaan,
              style: TextStyle(
                color: AppColors.lightGrey,
                fontWeight: FontWeight.w500,
                fontFamily: 'Satoshi',
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Dokumen',
              style: TextStyle(
                color: AppColors.lightGrey,
                fontWeight: FontWeight.w500,
                fontFamily: 'Satoshi',
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageIcon(
                  const AssetImage('assets/icons/document-pdf.png'),
                  size: 16.sp,
                  color: AppColors.lightGrey,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    namaDokumen,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      fontFamily: 'Satoshi',
                      color: AppColors.lightGrey,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: funcRead,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage('assets/icons/book.png'),
                      size: 20.sp,
                      color: AppColors.tertiary,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Baca',
                      style: TextStyle(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Satoshi',
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: funcDownloadPermohonan,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            const AssetImage(
                                'assets/icons/document-download.png'),
                            size: 20.sp,
                            color: AppColors.tertiary,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Flexible(
                            child: Text(
                              'Unduh Surat Permohonan',
                              style: TextStyle(
                                color: AppColors.tertiary,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Satoshi',
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: funcDownloadSuratTerbit,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            const AssetImage(
                                'assets/icons/document-download.png'),
                            size: 20.sp,
                            color: AppColors.tertiary,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Flexible(
                            child: Text(
                              'Unduh Surat Izin Terbit',
                              style: TextStyle(
                                color: AppColors.tertiary,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Satoshi',
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
