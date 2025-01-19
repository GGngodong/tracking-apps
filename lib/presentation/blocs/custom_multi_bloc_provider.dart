import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/presentation/blocs/beranda/upload/upload_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';

import 'auth/login/login_bloc.dart';
import 'auth/register/register_bloc.dart';

class CustomMultiBlocProvider extends StatelessWidget {
  final Widget child;
  const CustomMultiBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(userService: UserService())),
        BlocProvider(create: (context) => RegisterBloc(userService: UserService())),
        BlocProvider(create: (context) => ProfileBloc(userService: UserService())),
        BlocProvider(create: (context) => UploadBloc(userService: UserService()),)
      ],
      child: child,
    );
  }
}
