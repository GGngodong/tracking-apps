import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/lib/network/api_service.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _secureText = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _page(context);
  }

  Future<void> alertDialogError(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login failed'),
          content: Text('Error: Incorrect Email or Password!'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  Widget _page(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderTitle(
                            title: 'Masuk', subTitle: 'Selamat Datang!'),
                        SizedBox(
                          height: 22.h,
                        ),
                        CustomTextField(
                          textController: _emailController,
                          hintText: 'Masukan email anda',
                          header: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          textController: _passwordController,
                          hintText: 'Masukan password anda',
                          header: 'Password',
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
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
                          onPressed: () async {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            if (email.isNotEmpty && password.isNotEmpty) {
                              if (_formKey.currentState?.validate() ?? false) {
                                _login();
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Please fill in all fields')),
                              );
                            }
                          },
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
                          fun: () =>
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const RegisterPage(),
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': _emailController, 'password': _passwordController};

    var res = await ApiService().auth(data, '/users/login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage(isAdmin: true)),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
