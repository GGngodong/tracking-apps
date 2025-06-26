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

  void    _listener(LoginState state) {
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
        AppHelper.showCustomAlertDialog(
            onPositivePressed: () => Navigator.pop(context),
            title: 'Login Failed!',
            context: context,
            content: 'Invalid Email or Password');
      } else {
        AppHelper.showCustomAlertDialog(
            onPositivePressed: () => Navigator.pop(context),
            title: 'Login Failed!',
            context: context,
            content: 'Something went wrong!');
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
      AppHelper.showCustomAlertDialog(
          onPositivePressed: () => Navigator.pop(context),
          title: 'Login Failed!',
          context: context,
          content: 'Please ${httpResponseModel.message}.');
    }
  }
}
