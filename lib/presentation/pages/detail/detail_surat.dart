import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

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
  return Container();
}
