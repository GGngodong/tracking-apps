import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_tab_bar_2.dart';
import 'package:tracking_apps/presentation/pages/list/status/permit_approved.dart';
import 'package:tracking_apps/presentation/pages/list/status/permit_pending.dart';
import 'package:tracking_apps/presentation/pages/list/status/permit_reject.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitePage,
      body: SafeArea(
        child: CustomTabBar2(
          tabs: [
            Tab(child: Text('Pending'),),
            Tab(child: Text('Approved')),
            Tab(child: Text('Rejected')),
          ],
          tabViews: [
            PermitPending(),
            PermitApproved(),
            PermitReject()
          ],
        ),
      ),
    );
  }
}
