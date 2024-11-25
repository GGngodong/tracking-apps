import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_datepicker.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/pdf_upload.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: _body(context),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Pengunggahan Surat Izin',
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: headerAppBar),
    ),
    centerTitle: true,
    elevation: 0,
  );
}

Widget _body(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail Surat Izin',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        CustomTextField(
          hintText: 'Masukan deskripsi surat izin',
          header: 'Uraian',
        ),
        SizedBox(
          height: 12.h,
        ),
        CustomTextField(
          hintText: 'Masukan nomor surat',
          header: 'No. Surat',
        ),
        SizedBox(
          height: 12.h,
        ),
        CustomDatePicker(header: 'Tanggal Masuk Berkas', hintText: 'Ex. 01/02/2024'),
        SizedBox(
          height: 12.h,
        ),
        CustomTextField(
          hintText: 'Masukan nama perusahaan',
          header: 'Nama Perusahaan',
        ),
        SizedBox(
          height: 12.h,
        ),
        CustomTextField(
          hintText: 'Masukan nomor surat',
          header: 'Pilih nomor surat',
        ),
        SizedBox(
          height: 12.h,
        ),
        PdfUpload(
          header: 'Dokumen Surat',
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomButton(text: 'Unggah Surat', onPressed: () {}, isLogOut: false)
      ],
    ),
  );
}
