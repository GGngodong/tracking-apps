import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/divider_text.dart';
import 'package:tracking_apps/presentation/component/socialmedia_button.dart';
import 'package:tracking_apps/presentation/component/title_auth.dart';
import 'package:tracking_apps/presentation/main_page.dart';
import 'package:tracking_apps/presentation/pages/login/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            _headerRegister(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 240.h,
                  ),
                  const CustomTextField(
                      hintText: 'Masukan username anda', header: 'Username'),
                  SizedBox(
                    height: 16.h,
                  ),
                  const CustomTextField(
                      hintText: 'Masukan email anda', header: 'Email'),
                  SizedBox(
                    height: 16.h,
                  ),
                  const CustomTextField(
                    hintText: 'Masukan password anda',
                    header: 'Password',
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 46.h,
                  ),
                  CustomButton(
                    text: 'Sign up',
                    // onPressed: () => Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         const MainPage(statusCode: 200),
                    //   ),
                    // ),
                    onPressed: (){},
                    isLogOut: false,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  const DividerText(text: 'Masuk dengan'),
                  SizedBox(
                    height: 32.h,
                  ),
                  const SocialMediaButton(),
                  SizedBox(
                    height: 32.h,
                  ),
                  TitleAuth(
                    fun: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    firstText: 'Sudah mempunyai akun?',
                    secondText: ' Masuk',
                  ),
                  SizedBox(
                    height: 32.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerRegister() {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 220.h,
              decoration: BoxDecoration(gradient: headerAppBar),
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Image.asset('assets/home/indonesia-nobg.png'),
          ),
          Positioned(
            top: 120,
            left: 20,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Silahkan isi dibawah ini',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
