import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/divider_text.dart';
import 'package:tracking_apps/presentation/component/header.dart';
import 'package:tracking_apps/presentation/component/header_title.dart';
import 'package:tracking_apps/presentation/component/socialmedia_button.dart';
import 'package:tracking_apps/presentation/component/title_auth.dart';
import 'package:tracking_apps/presentation/main_page.dart';
import 'package:tracking_apps/presentation/pages/register/register.dart';

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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                Header(
                  heightSizedBox: 250.h,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderTitle(title: 'Masuk', subTitle: 'Selamat Datang!'),
                      SizedBox(
                        height: 22.h,
                      ),
                      CustomTextField(
                          hintText: 'Masukan email anda', header: 'Email'),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        hintText: 'Masukan password anda',
                        header: 'Password',
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.tertiary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomButton(
                        text: 'Sign In',
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(statusCode: 200),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      DividerText(text: 'Masuk dengan'),
                      SizedBox(
                        height: 32.h,
                      ),
                      SocialMediaButton(),
                      SizedBox(
                        height: 32.h,
                      ),
                      TitleAuth(
                        fun: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        ),
                        firstText: 'Belum mempunyai akun?',
                        secondText: ' Daftar',
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
