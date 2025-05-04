import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/pages/beranda/home_page.dart';
import 'package:tracking_apps/presentation/pages/list/status/status_page.dart';
import 'package:tracking_apps/presentation/pages/search/search_page.dart';

import 'pages/notification/notification_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/upload/upload_page.dart';

class MainPage extends StatefulWidget {
  final String role;

  const MainPage({super.key, required this.role});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  late final List<BottomNavigationBarItem> _navBarItems;

  @override
  void initState() {
    super.initState();

    // Initialize pages and navigation items based on admin status
    if (widget.role == 'ADMIN') {
      _pages = const [
        HomePage(),
        StatusPage(),
        SearchPage(),
        NotificationPage(),
        ProfilePage(),
      ];
      _navBarItems = [
        _buildNavBarItem('home'),
        _buildNavBarItem('status'),
        _buildNavBarItem('search'),
        _buildNavBarItem('notification'),
        _buildNavBarItem('user'),
      ];
    } else {
      _pages = const [
        HomePage(),
        UploadPage(),
        SearchPage(),
        NotificationPage(),
        ProfilePage(),
      ];
      _navBarItems = [

        _buildNavBarItem('home'),
        _buildNavBarItem('upload'),
        _buildNavBarItem('search'),
        _buildNavBarItem('notification'),
        _buildNavBarItem('user'),
      ];
    }
  }

  BottomNavigationBarItem _buildNavBarItem(String iconName) {
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: ImageIcon(AssetImage('assets/icons/$iconName-selected.png')),
      ),
      icon: ImageIcon(AssetImage('assets/icons/$iconName-unselected.png')),
      label: iconName.capitalize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
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
            fontFamily: 'Satoshi',
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
          items: _navBarItems,
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
