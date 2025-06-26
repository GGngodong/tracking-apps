import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/helper/validator_helper.dart';
import 'package:tracking_apps/presentation/blocs/auth/reset/reset_password_bloc.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';
import 'package:tracking_apps/presentation/component/custom_text_field.dart';

part 'reset_password_mixin.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with ResetPasswordMixin {
  @override
  Widget build(BuildContext context) {
    final ResetPasswordBloc resetBloc =
        BlocProvider.of<ResetPasswordBloc>(context);
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        _listener(state);
      },
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.whitePage,
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 200.h),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Satoshi',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'Please enter your email address. You will receive a link to create a new password via email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Satoshi',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomTextField(
                      hintText: 'Masukan Email Anda',
                      header: 'Email',
                      textController: _emailTextEditingController,
                      validator: ValidatorHelper.validateEmail,
                      validateOnChange: true,
                      onFieldSubmitted: (value) {
                        _submit(resetBloc);
                      },
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      text: 'Send',
                      onPressed: () {
                        _submit(resetBloc);
                      },
                      isLogOut: false,
                      isLoading: state.isLoading,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
