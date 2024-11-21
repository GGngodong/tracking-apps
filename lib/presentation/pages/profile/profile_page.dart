import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
    );
  }
  AppBar _appBar(){
    return AppBar(
      title: Text(
        'Profile',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppColors.primary
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
