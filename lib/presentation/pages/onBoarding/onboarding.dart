import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/ink_effect.dart';
import 'package:tracking_apps/presentation/main_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/home/dahana-hitam.png'),
          SizedBox(
            height: 45.h,
          ),
          Text(
            'Selamat datang di Dahana Tracking',
            style: TextStyle(
              fontSize: 20.sp,
              height: 1.5,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: 320.w,
            child: Text(
              "lorem ipsum dolor si amet \nlorem ipsum dolor si amet \nlorem ipsum dolor si amet",
              style: TextStyle(
                fontSize: 14.sp,
                height: 2,
                color: AppColors.lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 80.h,
          ),
          InkEffect(
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(
                    seconds: 1,
                  ),
                  pageBuilder: (context, animation, animationTime) {
                    return const OnBoardingNextPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: 8.h, bottom: 8.h, left: 16.w, right: 16.w),
              width: 358.w,
              height: 48.h,
              child: Center(
                child: Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class OnBoardingNextPage extends StatefulWidget {
  const OnBoardingNextPage({super.key});

  @override
  State<OnBoardingNextPage> createState() => _OnBoardingNextPageState();
}

class _OnBoardingNextPageState extends State<OnBoardingNextPage> {
  int slide = 0;
  bool pageIndex = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageIndex
                ? GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx < 0) {
                        setState(() {
                          slide = 1;
                          pageIndex = false;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/home/dahana-hitam.png'),
                        SizedBox(
                          height: 45.h,
                        ),
                        Text(
                          'Membantu memonitor Surat Izin',
                          style: TextStyle(
                            fontSize: 20.sp,
                            height: 1.5,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          width: 320.h,
                          child: Text(
                            'lorem ipsum dolor si amet \nlorem ipsum',
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 2,
                              color: AppColors.lightGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                : GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 0) {
                        setState(() {
                          slide = 0;
                          pageIndex = true;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/home/dahana-hitam.png'),
                        SizedBox(
                          height: 16.5.h,
                        ),
                        Text(
                          'Cepat dan Akurat',
                          style: TextStyle(
                            fontSize: 20.sp,
                            height: 1.5,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          width: 320.w,
                          child: Text(
                            'Anda dapat mengakses surat izin dengan mudah',
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 2,
                              color: AppColors.lightGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 53.57.h,
            ),
            sliderIndicator(),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 1),
                          pageBuilder: (context, animation, animationTime) {
                            return const MainPage(statusCode: 200);
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CircularPercentIndicator(
                    radius: 27,
                    backgroundWidth: 0,
                    lineWidth: 2.5,
                    percent: pageIndex ? 0.5 : 1,
                    progressColor: AppColors.primary,
                    center: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        setState(
                          () {
                            slide += 1;
                            pageIndex = false;
                            prefs.setBool("onBoarding", false);
                          },
                        );
                        if (slide == 2) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 1),
                              pageBuilder: (context, animation, animationTime) {
                                return const MainPage(statusCode: 200);
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder()),
                      child: Ink(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Container(
                          width: 44.w,
                          height: 44.h,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sliderIndicator() => AnimatedSmoothIndicator(
        activeIndex: slide,
        count: 2,
        effect: const ExpandingDotsEffect(
            spacing: 16.0,
            radius: 100.0,
            dotWidth: 8.0,
            dotHeight: 8.0,
            strokeWidth: 1.5,
            dotColor: AppColors.lightGrey,
            activeDotColor: AppColors.primary),
      );
}
