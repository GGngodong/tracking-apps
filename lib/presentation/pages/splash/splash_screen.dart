import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/configs/route/routes.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/domain/entity/user_model.dart';
import 'package:tracking_apps/generated/locale_keys.g.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_bloc.dart';
import 'package:tracking_apps/presentation/blocs/auth/register/register_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';

part 'splash_screen_mixin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashScreenMixin {
  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    final RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);
    final ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Container(
      color: AppColors.whitePage,
      child: FutureBuilder(
        future: _future(context),
        builder: (context, snapshot) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (snapshot.hasData) {
                _listener(
                  state,
                  loginBloc: _loginBloc,
                  profileBloc: _profileBloc,
                  registerBloc: _registerBloc,
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/home/dahana-hitam.png',
                  height: 100.h,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20.w,
                  ),
                  width: 300.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.whitePage,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
