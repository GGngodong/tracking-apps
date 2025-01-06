import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tracking_apps/common/service_locator.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/domain/usecases/login_usecase.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_user_bloc.dart';
import 'package:tracking_apps/presentation/component/ink_effect.dart';
import 'package:tracking_apps/presentation/component/onboarding_content.dart';
import 'package:tracking_apps/presentation/pages/login/login.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnBoardingPage> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image,
                              width: 300.w,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 320.w,
                              child: Text(
                                contents[i].description,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  height: 1.7,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sliderIndicator(),
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkEffect(
                            boxDecoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(pageBuilder:
                                    (context, animation, animationTime) {
                                  return BlocProvider<LoginUserBloc>(
                                    create: (context) => LoginUserBloc(
                                      loginUseCase: sl<LoginUseCase>(),
                                    ),
                                    child: LoginPage(),
                                  );
                                }, transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                }),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 8.h,
                                  bottom: 8.h,
                                  left: 16.w,
                                  right: 16.w),
                              width: 358.w,
                              height: 48.h,
                              child: Center(
                                child: Text(
                                  'Mulai Masuk',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(seconds: 1),
                                      pageBuilder:
                                          (context, animation, animationTime) {
                                        return const LoginPage();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                            opacity: animation, child: child);
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Lewati',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightGrey,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              CircularPercentIndicator(
                                radius: 27.r,
                                backgroundWidth: 0.w,
                                lineWidth: 2.5.w,
                                percent: _currentPage == 1 ? 1 : 0.5,
                                progressColor: AppColors.primary,
                                center: ElevatedButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                        prefs.setBool('onBoarding', false);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: const CircleBorder()),
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        width: 44.w,
                                        height: 44.h,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              )
                            ],
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
        activeIndex: _currentPage,
        count: 3,
        axisDirection: Axis.horizontal,
        effect: SlideEffect(
          spacing: 8.0,
          radius: 4.0.r,
          dotWidth: 24.0.w,
          dotHeight: 16.0.h,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
          dotColor: AppColors.lightGrey,
          activeDotColor: AppColors.primary,
        ),
      );
}
