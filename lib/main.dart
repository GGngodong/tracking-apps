import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/presentation/pages/onBoarding/onboarding.dart';
import 'package:tracking_apps/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Dahana Tracking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            fontFamily: 'Satoshi'),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: widget!,
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}
