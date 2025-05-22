import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_tab_bar_2.dart';
import 'package:tracking_apps/presentation/pages/list/permit/list_surat.dart';
import 'package:tracking_apps/presentation/pages/list/permit/terbit.dart';

class SelengkapnyaPage extends StatefulWidget {
  const SelengkapnyaPage({super.key});

  @override
  State<SelengkapnyaPage> createState() => _SelengkapnyaPageState();
}

class _SelengkapnyaPageState extends State<SelengkapnyaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Surat Izin',
          style: TextStyle(
            fontSize: 20.sp,
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
      body: SafeArea(
        child: CustomTabBar2(
          tabs: [
            Tab(child: Text('Semua')),
            Tab(child: Text('SI/TERBIT')),
          ],
          tabViews: [
            ListSuratPage(),
            TerbitPage(),
          ],
        ),
      ),
    );
  }
}
