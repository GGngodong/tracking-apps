import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class DetailPDFPage extends StatefulWidget {
  final String documentUrl;
  const DetailPDFPage({super.key, required this.documentUrl});

  @override
  State<DetailPDFPage> createState() => _DetailPDFPageState();
}

class _DetailPDFPageState extends State<DetailPDFPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: Container(
        child: SfPdfViewer.network(
            widget.documentUrl),
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Detail Surat',
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
