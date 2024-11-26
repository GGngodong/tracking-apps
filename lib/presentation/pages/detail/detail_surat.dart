import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/card_detail.dart';

class DetailSuratPage extends StatefulWidget {
  const DetailSuratPage({super.key});

  @override
  State<DetailSuratPage> createState() => _DetailSuratPageState();
}

class _DetailSuratPageState extends State<DetailSuratPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Baca Surat',
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
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 16.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Text(
          'Detail Surat',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      CardDetailSurat(
          date: 'date',
          categorySurat: 'categorySurat',
          noSurat: 'noSurat',
          namaPerusahaan: 'namaPerusahaan',
          namaDokumen: 'namaDokumen',
          noSuratIzinMabes: 'noSuratIzinMabes'),
    ],
  );
}
