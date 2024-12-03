import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/pages/beranda/home_page.dart';

import 'pages/notification/notification_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/upload/upload_page.dart';

class TestMainPage extends StatefulWidget {
  final int statusCode;
  final bool isAdmin;

  const TestMainPage({super.key, required this.statusCode, required this.isAdmin});

  @override
  State<TestMainPage> createState() => _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: PageController(initialPage: _currentIndex),
          children: _getPageList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          elevation: 25,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
            color: AppColors.lightGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          selectedLabelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          unselectedItemColor: AppColors.lightGrey,
          selectedItemColor: AppColors.primary,
          iconSize: 24.r,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: _getNavBarItems(),
        ),
      ),
    );
  }

  List<Widget> _getPageList() {
    // Return pages based on admin status
    if (widget.isAdmin) {
      return const [
        HomePage(),
        UploadPage(),
        NotificationPage(),
        ProfilePage(),
      ];
    } else {
      return const [
        HomePage(),
        NotificationPage(),
        ProfilePage(),
      ];
    }
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    // Return navigation bar items based on admin status
    if (widget.isAdmin) {
      return [
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const ImageIcon(
                AssetImage('assets/icons/home-selected.png')),
          ),
          icon: const ImageIcon(
              AssetImage('assets/icons/home-unselected.png')),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: const ImageIcon(
                  AssetImage('assets/icons/upload-selected.png'))),
          icon: const ImageIcon(
              AssetImage('assets/icons/upload-unselected.png')),
          label: "Unggah",
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const ImageIcon(
                AssetImage('assets/icons/notification-selected.png')),
          ),
          icon: const ImageIcon(
              AssetImage('assets/icons/notification-unselected.png')),
          label: "Notifikasi",
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const ImageIcon(
                AssetImage('assets/icons/user-selected.png')),
          ),
          icon: const ImageIcon(
              AssetImage('assets/icons/user-unselected.png')),
          label: "Profil",
        ),
      ];
    } else {
      return [
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const ImageIcon(
                AssetImage('assets/icons/home-selected.png')),
          ),
          icon: const ImageIcon(
              AssetImage('assets/icons/home-unselected.png')),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const ImageIcon(
                AssetImage('assets/icons/notification-selected.png')),
          ),
          icon: const ImageIcon(
              AssetImage('assets/icons/notification-unselected.png')),
          label: "Notifikasi",
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: const ImageIcon(
                AssetImage('assets/icons/user-selected.png')),
          ),
          icon: const ImageIcon(
              AssetImage('assets/icons/user-unselected.png')),
          label: "Profil",
        ),
      ];
    }
  }
}
