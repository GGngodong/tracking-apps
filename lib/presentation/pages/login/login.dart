import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/presentation/component/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Sign In Successful!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Header(
                imageBg: 'assets/home/indonesia-nobg.png',
                imageFg: 'assets/home/dahana.png',
                height: 100.h,
                topFg: 80,
                leftFg: 0,
                rightFg: 0,
                topBg: 80,
                leftBg: 0,
                rightBg: 0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
