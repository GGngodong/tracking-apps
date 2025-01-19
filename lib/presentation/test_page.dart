import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/presentation/component/card_expanded.dart';
import 'package:tracking_apps/presentation/component/skeleton_card.dart';
import 'package:tracking_apps/presentation/pages/detail/detailDokumen/detail_pdf.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.amber,
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SkeletonCard();
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 8.h,
              );
            },
            itemCount: 5),
      ),
    );
  }
}
