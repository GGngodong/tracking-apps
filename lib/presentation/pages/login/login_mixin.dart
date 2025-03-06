part of 'login.dart';

mixin LoginMixin on State<LoginPage> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  // void _forgotPasswordListener(RegisterState state) async {
  //   if (state is ForgotPasswordCheckSuccess) {
  //     if (state.data != null && state.data!) {
  //       if (state.verificationCode != null) {
  //         context.go(Routes.verify.path);
  //       }
  //     }
  //   } else if (state is ForgotPasswordCheckFailed) {
  //     print('================== CURRENT STATE : $state ==================');
  //     AppHelper.alertDialogMessage(
  //         context: context, content: LocaleKeys.non_existent_user_message.tr());
  //   } else if (state is CheckFailed) {
  //     AppHelper.alertDialogMessage(
  //         context: context, content: LocaleKeys.something_went_wrong.tr());
  //     print('================== CURRENT STATE : $state ==================');
  //   }
  // }

  void _listener(LoginState state) {
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    if (state is LoginSuccess) {
      print('================== CURRENT STATE : $state ==================');
      profileBloc.add(SetUser(user: state.user));
      context.go(Routes.initial.path);
      if (state.user.role == 'ADMIN') {
        context.go(Routes.navigation.path, extra: true);
      } else {
        context.go(Routes.navigation.path, extra: false);
      }
    } else if (state is LoginFailed) {
      print('================== CURRENT STATE  : $state ==================');
      if (state.statusCode == 401) {
        AppHelper.alertDialogMessage(isFailed: true, title: 'Login Failed!',
            context: context, content: 'Invalid Email or Password');
      } else {
        AppHelper.alertDialogMessage(isFailed: true, title: 'Login Failed!',
            context: context, content: 'Something went wrong!');
      }
    }
  }

  void _submit(LoginBloc loginBloc) {
    HttpResponseModel httpResponseModel = AppHelper.checkEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    );
    print('================== CURRENT : $loginBloc ==================');
    if (httpResponseModel.statusCode == 200) {
      loginBloc.add(
        LoginButtonPressed(
          email: _emailTextEditingController.text.trim(),
          password: _passwordTextEditingController.text.trim(),
        ),
      );
    } else {
      AppHelper.alertDialogMessage(
        isFailed: true,
          title: 'Login Failed!',
          context: context,
          content: 'Please ${httpResponseModel.message}.');
    }
  }
}
