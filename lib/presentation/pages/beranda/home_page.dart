import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/card_surat.dart';
import 'package:tracking_apps/presentation/component/header.dart';
import 'package:tracking_apps/presentation/component/search_bar_home_page.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitePage,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Header(
                  imageBg: 'assets/home/dahana-gedung.png',
                  imageFg: 'assets/home/dahana.png',
                  height: 100.h,
                  topFg: 90,
                  leftFg: 0,
                  rightFg: 0,
                  topBg: 40,
                  leftBg: 0,
                  rightBg: 0,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                          minWidth: 0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          child: SearchBarHomePage(
                            hintText: 'Cari Surat Izin',
                            searchType: TypeSearchBar.withDropdownFilter,
                            items: const ['OPS', 'DTM', 'DTU', 'DKK'],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Text(
                    'Surat Izin',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return CardSurat(
                        date: '28 Februari 2023',
                        categorySurat: 'OPS',
                        namaDokumen: 'Angkut Subang Bati',
                        namaPerusahaan: 'PT Dahana',
                        noSurat: 'B/008/I/2023/Korp-Jkt',
                        noSuratIzinMabes: 'SI/1128/I/YAN.2.10./2023',
                        funcDownload: () {},
                        funcRead: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailSuratPage(),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
                    itemCount: 3,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
