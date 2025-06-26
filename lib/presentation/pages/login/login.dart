import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/route/routes.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/helper/validator_helper.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/header.dart';
import 'package:tracking_apps/presentation/component/header_title.dart';
import 'package:tracking_apps/presentation/component/title_auth.dart';
import 'package:tracking_apps/presentation/pages/login/reset/reset_password.dart';
import 'package:tracking_apps/presentation/pages/register/register.dart';

part 'login_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        _listener(state);
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
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
                              title: 'Masuk',
                              subTitle: 'Selamat Datang!',
                            ),
                            SizedBox(height: 22.h),
                            CustomTextField(
                              textController: _emailTextEditingController,
                              hintText: 'Masukan email anda',
                              header: 'Email',
                              validator: ValidatorHelper.validateEmail,
                              validateOnChange: true,
                              onFieldSubmitted: (value) {
                                _submit(_loginBloc);
                              },
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              textController: _passwordTextEditingController,
                              hintText: 'Masukan password anda',
                              header: 'Password',
                              validator: ValidatorHelper.validatePassword,
                              validateOnChange: true,
                              isPassword: true,
                              onFieldSubmitted: (value) {
                                _submit(_loginBloc);
                              },
                            ),
                            SizedBox(height: 22.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ResetPasswordPage()),
                                  );
                                },
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
                            SizedBox(height: 24.h),
                            CustomButton(
                              isLoading: state.isLoading,
                              text: 'Sign In',
                              onPressed: () {
                                _submit(_loginBloc);
                              },
                              isLogOut: false,
                            ),
                            SizedBox(height: 32.h),
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
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
