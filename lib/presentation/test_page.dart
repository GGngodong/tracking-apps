import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/presentation/component/card_expanded.dart';
import 'package:tracking_apps/presentation/pages/detail/detailDokumen/detail_pdf.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
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
                  builder: (BuildContext context) => DetailPDFPage(),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8.h,
            );
          },
          itemCount: 5),
    );
  }
}
