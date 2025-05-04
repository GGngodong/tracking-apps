part of "register.dart";

mixin RegisterMixin on State<RegisterPage> {
  late TextEditingController _usernameTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _verificationCodeTextEditingController;
  late TextEditingController _divisionTextEditingController;

  @override
  void initState() {
    super.initState();
    _divisionTextEditingController = TextEditingController();
    _usernameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _verificationCodeTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _divisionTextEditingController.dispose();
    _usernameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _verificationCodeTextEditingController.dispose();
  }

  void _submit(RegisterBloc registerBloc) {
    HttpResponseModel httpResponseModel =
        AppHelper.checkUsernameEmailAndPassword(
      username: _usernameTextEditingController.text.trim(),
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    );
    if (httpResponseModel.statusCode == 200) {
      registerBloc.add(
        RegisterButtonPressed(
          username: _usernameTextEditingController.text.trim(),
          email: _emailTextEditingController.text.trim(),
          password: _passwordTextEditingController.text.trim(),
          division: _divisionTextEditingController.text.trim(),
        ),
      );
      Future.delayed(const Duration(seconds: 10), () {
        registerBloc.add(const ClearRegisterData());
      });
      AppHelper.showCustomAlertDialog(
        title: 'Register Success!',
        context: context,
        content: 'Please login to continue.',
        onPositivePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
      );
    } else {
      AppHelper.showCustomAlertDialog(
        onPositivePressed: () => Navigator.pop(context),
        title: 'Register Failed!',
        context: context,
        content: 'Please ${httpResponseModel.message}.',
      );
    }
  }

  void _listener(RegisterState state) async {
    if (state is CheckSuccess) {
      if (state.data != null && !state.data!) {
        if (state.verificationCode != null) {
          AppHelper.showCustomAlertDialog(
            context: context,
            content: 'Verification code has been sent to your email',
            onPositivePressed: () => context.go(Routes.login.path),
          );
        }
      } else {
        AppHelper.showCustomAlertDialog(
            onPositivePressed: () => Navigator.pop(context),
            title: 'Register Failed!',
            context: context,
            content: 'Email already exists');
        print('================== CURRENT STATE : $state ==================');
      }
    } else if (state is CheckFailed) {
      AppHelper.showCustomAlertDialog(
          onPositivePressed: () => Navigator.pop(context),
          title: 'Register Failed!',
          context: context,
          content: 'Something went wrong!');
      print('================== CURRENT STATE : $state ==================');
    }
  }
}
