import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_apps/common/app_helper.dart';
import 'package:tracking_apps/configs/route/routes.dart';
import 'package:tracking_apps/configs/theme/app_colors.dart';
import 'package:tracking_apps/presentation/blocs/auth/login/login_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/component/card_profil.dart';
import 'package:tracking_apps/presentation/component/custom_button.dart';

import '../../../generated/locale_keys.g.dart';

part 'profile_mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
      backgroundColor: AppColors.whitePage,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Profile',
        style: TextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: headerAppBar),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState ) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 30.h,
                  ),
                  CardProfile(
                    userName: '${profileState.user?.userName}',
                    email: '${profileState.user?.email}',
                    division: '${profileState.user?.division}',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(text: 'Log Out', onPressed: () => _showLogOutDialog(context, loginBloc), isLogOut: true)
                ],
              ),
            );
          }
        );
      }

    );
  }
}
