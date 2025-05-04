import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class CustomTabBar2 extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;
  void Function(int)? onTap;
  final void Function(int)? onTabIndexChanged;
  int tabGo;

  CustomTabBar2(
      {super.key,
      required this.tabs,
      required this.tabViews,
      this.onTap,
      this.onTabIndexChanged,
      this.tabGo = 0});

  @override
  State<CustomTabBar2> createState() => _CustomTabBar2State();
}

class _CustomTabBar2State extends State<CustomTabBar2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.tabGo,
    );
    _tabController.animateTo(widget.tabGo);

    _tabController.addListener(
      () {
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) {
            setState(
              () {},
            );

            if (widget.onTabIndexChanged != null) {
              widget.onTabIndexChanged!(_tabController.index);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi'),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: -5,
                ),
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.tertiary,
                physics: BouncingScrollPhysics(),
                tabs: widget.tabs),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child:
              TabBarView(controller: _tabController, children: widget.tabViews),
        ),
      ],
    );
  }
}
