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
  final VoidCallback funcDownload;

  const CardSurat({
    required this.date,
    required this.categorySurat,
    required this.namaDokumen,
    required this.namaPerusahaan,
    required this.noSurat,
    required this.noSuratIzinMabes,
    required this.processStatus,
    required this.funcRead,
    required this.funcDownload,
    required this.detailSurat,
    required this.uploadStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Color borderUploadColor;
    late String typeStatus;
    late TextStyle fontStatusStyle;
    late TextStyle fontUploadSyle;
    if (uploadStatus == 'PENDING') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      borderUploadColor = const Color(0xFFBDBDBD);
      typeStatus = 'PENDING';
    } else if (uploadStatus == 'APPROVED') {
      fontStatusStyle = TextStyle(
        color: Color(0xFF32A850),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      borderUploadColor = const Color(0xFF32A850);
      typeStatus = 'APPROVED';
    } else if (uploadStatus == 'REJECTED') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFAF4848),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      fontUploadSyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      borderUploadColor = const Color(0xFFAF4848);
      typeStatus = 'REJECTED';
    } else if (processStatus == 'Draft Created') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Draft Created';
    } else if (processStatus == 'Archiving') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Archiving';
    } else if (processStatus == 'Submission') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Submission';
    } else if (processStatus == 'Verification') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Verification';
    } else if (processStatus == 'Initial Approval') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Initial Approval';
    } else if (processStatus == 'Second Approval') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Second Approval';
    } else if (processStatus == 'Drafter') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Drafter';
    } else if (processStatus == 'Final Approval') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        fontFamily: 'Satoshi',
      );
      typeStatus = 'On Final Approval';
    } else if (processStatus == 'Printing') {
      fontStatusStyle = TextStyle(
        color: Color(0xFFBDBDBD),
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
                      typeStatus,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: funcDownload,
                    child: Container(
                      width: 122.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.primary),
                        color: Colors.white,
                      ),
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
                          Text(
                            'Unduh',
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
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: funcRead,
                    child: Container(
                      width: 186.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.primary),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            const AssetImage('assets/icons/book.png'),
                            size: 20.sp,
                            color: AppColors.tertiary,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
