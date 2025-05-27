import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_apps/configs/network/notification/notification_service.dart';
import 'package:tracking_apps/configs/network/user_service.dart';
import 'package:tracking_apps/presentation/blocs/auth/reset/reset_password_bloc.dart';
import 'package:tracking_apps/presentation/blocs/notification/all/notification_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/detail/get_detail_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/edit/edit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/approved/get_approved_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/get_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/latest/get_latest_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/pending/get_pending_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/reject/get_reject_permit_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/listPermit/release/get_permit_release_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/search/search_bloc.dart';
import 'package:tracking_apps/presentation/blocs/permit/upload/upload_bloc.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';

import 'auth/login/login_bloc.dart';
import 'auth/register/register_bloc.dart';
import 'notification/detail/notification_detail_bloc.dart';
import 'notification/edit/notification_edit_bloc.dart';

class CustomMultiBlocProvider extends StatelessWidget {
  final Widget child;

  const CustomMultiBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(userService: UserService())),
        BlocProvider(
            create: (context) => RegisterBloc(userService: UserService())),
        BlocProvider(
            create: (context) => ProfileBloc(userService: UserService())),
        BlocProvider(
            create: (context) => UploadBloc(userService: UserService())),
        BlocProvider(
            create: (context) => PermitLetterBloc(userService: UserService())),
        BlocProvider(
            create: (context) =>
                DetailPermitLetterBloc(userService: UserService())),
        BlocProvider(create: (context) => EditBloc(userService: UserService())),
        BlocProvider(
            create: (context) => SearchBloc(userService: UserService())),
        BlocProvider(
            create: (context) =>
                PermitLetterApprovedBloc(userService: UserService())),
        BlocProvider(
            create: (context) =>
                PermitLetterRejectBloc(userService: UserService())),
        BlocProvider(
            create: (context) =>
                PermitLetterPendingBloc(userService: UserService())),
        BlocProvider(
          create: (context) =>
              PermitLetterLatestBloc(userService: UserService()),
        ),
        BlocProvider(
            create: (context) =>
                PermitLetterReleaseBloc(userService: UserService())),
        BlocProvider(
            create: (context) =>
                NotificationBloc(notificationService: NotificationService())),
        BlocProvider(
            create: (context) => NotificationDetailBloc(
                notificationService: NotificationService())),
        BlocProvider(
            create: (context) => NotificationEditBloc(
                notificationService: NotificationService())),
        BlocProvider(
          create: (context) => ResetPasswordBloc(userService: UserService()),
        )
      ],
      child: child,
    );
  }
}
