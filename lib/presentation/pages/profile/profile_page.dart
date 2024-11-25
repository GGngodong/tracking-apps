import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/card_profil.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Profile',
        style: TextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.white),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          const CardProfile(
            userName: 'Kim Jong-Un',
            email: 'kimjong.un@dahana.id',
            role: 'admin',
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(text: 'Log Out', onPressed: () {}, isLogOut: true)
        ],
      ),
    );
  }
}
