import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_bottom_sheet_filter.dart';
import 'package:tracking_apps/presentation/component/custom_search_bar.dart';

import 'component/custom_tab_bar.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 70.h,
        backgroundColor: AppColors.whitePage,
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomSearchBar(
                  hintText: 'Test',
                  searchType: TypeSearchBar.regular,
                  items: const [],
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      scrollControlDisabledMaxHeightRatio: 0.85,
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      builder: (context) => CustomBottomSheetFilter(),
                    );
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    size: 24.sp,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CustomTabBar(
              tabs: [
                Tab(child: Text('Cerita Terkini')),
                Tab(child: Text('MSIB')),
              ],
              tabViews: [
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('Item $index'),
                        ),
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('Item $index'),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
