import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/card_detail.dart';
import 'package:tracking_apps/presentation/pages/detail/detailDokumen/detail_pdf.dart';

class DetailSuratPage extends StatefulWidget {
  const DetailSuratPage({super.key});

  @override
  State<DetailSuratPage> createState() => _DetailSuratPageState();
}

class _DetailSuratPageState extends State<DetailSuratPage> {
  bool isAdmin = true;
  bool isEditing = false;
  String date = '';
  String categorySurat = '';
  String noSurat = '';
  String namaPerusahaan = '';
  String namaDokumen = '';
  String noSuratIzinMabes = '';

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAdmin && isEditing ? 'Edit Detail Surat' : 'Detail Surat',
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
      ),
      body: SingleChildScrollView(
        child: Column(
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
              date: date,
              categorySurat: categorySurat,
              namaDokumen: namaDokumen,
              namaPerusahaan: namaPerusahaan,
              noSurat: noSurat,
              noSuratIzinMabes: noSuratIzinMabes,
              isEditing: isEditing,
              onFieldChanged: (field, value) {
                if (field == 'date') date = value;
                if (field == 'categorySurat') categorySurat = value;
                if (field == 'noSurat') noSurat = value;
                if (field == 'namaPerusahaan') namaPerusahaan = value;
                if (field == 'namaDokumen') namaDokumen = value;
                if (field == 'noSuratIzinMabes') noSuratIzinMabes = value;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailPDFPage(),
                      ),
                    ),
                    child: Text(
                      'Lihat Dokumen',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  if (isAdmin)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isEditing ? Color(0xFF39B43B) : Color(0xFFAF4848),
                      ),
                      onPressed: toggleEdit,
                      child: Text(
                        isEditing ? 'Save' : 'Edit Field',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
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
