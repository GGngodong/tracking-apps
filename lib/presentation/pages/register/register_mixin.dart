part of "register.dart";

mixin RegisterMixin on State<RegisterPage> {
  late TextEditingController _usernameTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _verificationCodeTextEditingController;

  @override
  void initState() {
    super.initState();
    _usernameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _verificationCodeTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _verificationCodeTextEditingController.dispose();
  }

  void _submit(RegisterBloc registerBloc) {
    HttpResponseModel httpResponseModel = AppHelper.checkUsernameEmailAndPassword(
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
        ),
      );
    } else {
      AppHelper.alertDialogMessage(context: context, content: httpResponseModel.message);
    }
  }

  void _listener(RegisterState state) async {
    if (state is CheckSuccess) {
      if (state.data != null && !state.data!) {
        if (state.verificationCode != null) {
          context.go(Routes.login.path);
        }
      } else {
        AppHelper.alertDialogMessage(context: context, content: LocaleKeys.user_exists_message.tr());
        print('================== CURRENT STATE : $state ==================');
      }
    } else if (state is CheckFailed) {
      AppHelper.alertDialogMessage(context: context, content: LocaleKeys.something_went_wrong.tr());
      print('================== CURRENT STATE : $state ==================');
    }
  }
}
