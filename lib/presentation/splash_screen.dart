import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_apps/configs/screen/screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(microseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_controller);

  late SharedPreferences pref;
  late bool direct;

  void getPrefs() async {
    pref = await SharedPreferences.getInstance();
    direct = pref.getBool('onBoarding') ?? true;
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
        body: SizedBox(
      width: screenWidth(context),
      height: screenHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/home/dahana-hitam.png',
              height: 136.h,
              width: 60.w,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/home/dahana-hitam.png',
              height: 34.h,
              width: 147.w,
            ),
          ),
        ],
      ),
    ));
  }
}
