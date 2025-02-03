import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_apps/configs/route/routes.dart';
import 'package:tracking_apps/presentation/blocs/profile/profile_bloc.dart';
import 'package:tracking_apps/presentation/main_page.dart';
import 'package:tracking_apps/presentation/pages/beranda/home_page.dart';
import 'package:tracking_apps/presentation/pages/listSurat/list_surat.dart';
import 'package:tracking_apps/presentation/pages/login/login.dart';
import 'package:tracking_apps/presentation/pages/notification/notification_page.dart';
import 'package:tracking_apps/presentation/pages/profile/profile_page.dart';
import 'package:tracking_apps/presentation/pages/register/register.dart';
import 'package:tracking_apps/presentation/pages/search/search_page.dart';
import 'package:tracking_apps/presentation/pages/splash/splash_screen.dart';
import 'package:tracking_apps/presentation/pages/upload/upload_page.dart';

final class RouterManager {
  RouterManager._();

  static GoRouter router({required String? userRole}) {
    return GoRouter(
      routes: [
        GoRoute(
          path: Routes.initial.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
            path: Routes.navigation.path,
            builder: (context, state) {
              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  return MainPage(role: profileState.user!.role);
                },
              );
            }),
        GoRoute(
            path: Routes.homePage.path,
            builder: (context, state) => const HomePage()),
        GoRoute(
            path: Routes.uploadData.path,
            builder: (context, state) => UploadPage()),
        GoRoute(
            path: Routes.search.path,
            builder: (context, state) => const SearchPage()),
        GoRoute(
            path: Routes.notification.path,
            builder: (context, state) => const NotificationPage()),
        GoRoute(
          path: Routes.profile.path,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: Routes.login.path,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: Routes.register.path,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
            path: Routes.listPermit.path,
            builder: (context, state) => ListSuratPage()),
      ],
    );
  }
}
