import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/card_expanded.dart';
import 'package:tracking_apps/presentation/component/custom_search_bar.dart';
import 'package:tracking_apps/presentation/pages/detail/detail_surat.dart';

class ListSuratPage extends StatefulWidget {
  const ListSuratPage({super.key});

  @override
  State<ListSuratPage> createState() => _ListSuratPageState();
}

class _ListSuratPageState extends State<ListSuratPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePage,
      // backgroundColor: Colors.amber,
      appBar: _appBar(),
      body: _body(context),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'List Surat',
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
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        CustomSearchBar(
          hintText: 'Cari Surat Izin',
          searchType: TypeSearchBar.withDropdownFilter,
          items: const ['OPS', 'DTM', 'DTU', 'DKK'],
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return CardExpanded(
              date: '28 Februari 2023',
              categorySurat: 'OPS',
              namaDokumen: 'Angkut Subang Bati',
              namaPerusahaan: 'PT Dahana',
              noSurat: 'B/008/I/2023/Korp-Jkt',
              noSuratIzinMabes: 'SI/1128/I/YAN.2.10./2023',
              fun: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const DetailSuratPage(),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.h,
            );
          },
          itemCount: 5,
        ),
      ],
    ),
  );
}
