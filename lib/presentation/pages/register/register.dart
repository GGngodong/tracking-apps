import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/configs/network/http_response_model.dart';
import 'package:tracking_apps/configs/route/routes.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/auth/register/register_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';
import 'package:tracking_apps/presentation/component/dropdown_form_status_tahapan.dart';
import 'package:tracking_apps/presentation/component/title_auth.dart';
import 'package:tracking_apps/presentation/pages/login/login.dart';

part 'register_mixin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        _listener(state);
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
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
                        CustomTextField(
                          hintText: 'Masukan username anda',
                          header: 'Username',
                          textController: _usernameTextEditingController,
                          onFieldSubmitted: (value) {
                            _submit(registerBloc);
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          hintText: 'Masukan email anda',
                          header: 'Email',
                          textController: _emailTextEditingController,
                          onFieldSubmitted: (value) {
                            _submit(registerBloc);
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomDropdownForm(
                          hintText: 'Pilih Divisi',
                          header: 'Divisi',
                          onCategoryChanged: (value) {
                            _submit(registerBloc);
                          },
                          textEditingController: _divisionTextEditingController,
                          listDropdown: ['LOG.', 'DTU', 'DM/GM', 'DKK'],
                        ),
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        CustomTextField(
                          hintText: 'Masukan password anda',
                          header: 'Password',
                          isPassword: true,
                          textController: _passwordTextEditingController,
                          onFieldSubmitted: (value) {
                            _submit(registerBloc);
                          },
                        ),
                        SizedBox(
                          height: 46.h,
                        ),
                        CustomButton(
                          text: 'Sign up',
                          onPressed: () {
                            if (_usernameTextEditingController.text.isEmpty) {
                              AppHelper.showCustomAlertDialog(
                                onPositivePressed: () =>
                                    Navigator.pop(context),
                                title: 'Username tidak boleh kosong!',
                                context: context,
                                content: 'Silahkan isi username.',
                              );
                            }
                            if (_emailTextEditingController.text.isEmpty) {
                              AppHelper.showCustomAlertDialog(
                                onPositivePressed: () =>
                                    Navigator.pop(context),
                                title: 'Email tidak boleh kosong!',
                                context: context,
                                content: 'Silahkan isi email.',
                              );
                            }
                            if (_divisionTextEditingController.text.isEmpty) {
                              AppHelper.showCustomAlertDialog(
                                onPositivePressed: () =>
                                    Navigator.pop(context),
                                title: 'Divisi tidak boleh kosong!',
                                context: context,
                                content: 'Silahkan pilih divisi.',
                              );
                            }
                            if (_passwordTextEditingController.text.isEmpty) {
                              AppHelper.showCustomAlertDialog(
                                onPositivePressed: () =>
                                    Navigator.pop(context),
                                title: 'Password tidak boleh kosong!',
                                context: context,
                                content: 'Silahkan isi password.',
                              );
                            }
                            if (_passwordTextEditingController.text.length < 8) {
                              AppHelper.showCustomAlertDialog(
                                onPositivePressed: () =>
                                    Navigator.pop(context),
                                title: 'Password minimal 8 karakter!',
                                context: context,
                                content: 'Silahkan isi password.',
                              );
                            }
                            _submit(registerBloc);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const LoginPage(),
                            //   )
                            // );
                          },
                          isLogOut: false,
                          isLoading: state.isLoading,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        // const DividerText(text: 'Masuk dengan'),
                        // // SizedBox(
                        // //   height: 32.h,
                        // // ),
                        // // const SocialMediaButton(),
                        // // SizedBox(
                        // //   height: 32.h,
                        // // ),
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
        },
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
