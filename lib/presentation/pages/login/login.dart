import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/constant.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/data/local/shared_pref_helper.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_user_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/divider_text.dart';
import 'package:tracking_apps/presentation/component/header.dart';
import 'package:tracking_apps/presentation/component/header_title.dart';
import 'package:tracking_apps/presentation/component/loading_login.dart';
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
  late LoginUserBloc _loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState () {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginUserBloc, LoginUserState>(
      builder: (context, state) {
        print('current state: $state');
        _loginBloc = BlocProvider.of<LoginUserBloc>(context);

        if (state is LoginUserNoInternet) {
          return _loginPage(context, state);
        } else if (state is LoginUserFailure) {
          return _loginPage(context, state);
        } else if (state is LoginUserSuccess) {
          return _loginPage(context, state);
        } else {
          return _loginPage(context, state);
        }
      },
      listener: (context, state) async {
        if (state is LoginUserFailure) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Login Failed'),
              content: Text('Error: ${state.message}'),
             actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else if (state is LoginUserSuccess) {
          final token = state.response['data']['token'];
          final role = state.response['data']['user']['role'];

          final prefsHelper = SharedPrefHelper();
          await prefsHelper.saveToken(token);
          await prefsHelper.saveRole(role);

          final isAdmin = role == 'ADMIN';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MainPage(isAdmin: isAdmin),
            ),
          );
        }
      },
    );
  }

  Widget _loginPage(BuildContext context, LoginUserState state) {
    if (state is LoginUserLoading) {
      return LoadingLogin();
    } else if (state is LoginUserSuccess) {
      return Center(
        child: Text('Login Succesful'),
      );
    } else if (state is LoginUserFailure) {
      return _page(context);
    } else {
      return _page(context);
    }
  }

  Widget _page(BuildContext context) {
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
                      const HeaderTitle(
                          title: 'Masuk', subTitle: 'Selamat Datang!'),
                      SizedBox(
                        height: 22.h,
                      ),
                      CustomTextField(
                        textController: _emailController,
                        hintText: 'Masukan email anda',
                        header: 'Email',
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        textController: _passwordController,
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
                        onPressed: () {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          if (email.isNotEmpty && password.isNotEmpty) {
                            _loginBloc.add(LoginUserRequested(
                              email: email,
                              password: password,
                            ));
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
                        fun: () => Navigator.push(
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
