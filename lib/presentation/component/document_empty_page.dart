import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/document_empty.dart';

class DocumentEmptyPage extends StatelessWidget {
  const DocumentEmptyPage({super.key});

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
        child: DocumentEmpty(),
      ),
    );
  }
}
