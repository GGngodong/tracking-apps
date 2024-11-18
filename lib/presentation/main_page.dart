import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/pages/beranda/home_page.dart';

import 'pages/notification/notification_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/upload/upload_page.dart';

class MainPage extends StatefulWidget {
  final int statusCode;
  const MainPage({super.key, required this.statusCode});

  @override
  State<MainPage> createState() => _HomePageState();
}

enum NavBarMenu { Home, Upload, Notifciation, Profile }

class _HomePageState extends State<MainPage> {
  NavBarMenu navBarMenu = NavBarMenu.Home;
  PageController pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Flexible(
              flex: 9,
              child: SizedBox(
                width: double.infinity,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: 4,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _switchPage(index);
                  },
                ),
              ),
            ),
          ],
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
              fontWeight: FontWeight.w700),
          selectedLabelStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700),
          unselectedItemColor: AppColors.lightGrey,
          selectedItemColor: AppColors.primary,
          iconSize: 24.r,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            });
          },
          items: [
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
                    AssetImage('assets/icons/upload-selected.png')),
              ),
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
          ],
        ),
      ),
    );
  }
}

dynamic _switchPage(int index) {
  switch (index) {
    case 0:
      return const HomePage();
    case 1:
      return const UploadPage();
    case 2:
      return const NotificationPage();
    case 3:
      return const ProfilePage();
    default:
  }
}
