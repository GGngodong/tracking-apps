part of 'splash_screen.dart';

mixin SplashScreenMixin on State<SplashScreen> {
  final UserService _userService = UserService();

  Future<bool> _future(BuildContext context) async {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    String? authToken = await _userService.getAuthTokenFromSP();

    if (authToken == null) {
      loginBloc.add(LogoutButtonPressed(authToken: ''));
      if (context.mounted) {
        context.go(Routes.login.path);
      }
    } else {
      loginBloc.add(ValidateAuthToken(authToken: authToken));
    }
    return true;
  }

  bool _checkValues(UserModel userModel) {
    if (userModel.email.isEmpty) return false;
    return true;
  }

  void _listener(LoginState state,
      {required LoginBloc loginBloc,
        required RegisterBloc registerBloc,
        required ProfileBloc profileBloc}) async {
    if (!mounted) return;

    if (state is ValidateSuccess) {
      profileBloc.add(SetUser(user: state.user));
      registerBloc.add(const ClearRegisterData());

      if (_checkValues(state.user)) {
        context.go(Routes.navigation.path);
      } else {
        context.go(Routes.profile.path);
      }
    } else if (state is ValidateFailed) {
      loginBloc.add(LogoutButtonPressed(authToken: ''));
      registerBloc.add(const ClearRegisterData());

      if (!mounted) return;
      context.go(Routes.login.path);

      if (!mounted) return;
      AppHelper.showCustomAlertDialog(
        onPositivePressed: () {
          Navigator.pop(context);
          context.go(Routes.login.path);
        },
        context: context,
        content: 'Session Expired! Please login again.',
      );
    }
  }

}
