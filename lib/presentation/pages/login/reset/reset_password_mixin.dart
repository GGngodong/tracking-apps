part of 'reset_password.dart';

mixin ResetPasswordMixin on State<ResetPasswordPage> {
  late TextEditingController _emailTextEditingController;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
  }

  void _listener(ResetPasswordState state) {
    if (state is ResetPasswordSuccess) {
      AppHelper.alertDialogMessage(
        title: 'Password reset link successfully sent',
        context: context,
        content: state.message!,
      );
    } else if (state is ResetPasswordFailed) {
      AppHelper.alertDialogMessage(
        title: 'Failed to send password reset link',
        context: context,
        content: state.message!,
      );
    }
  }

  void _submit(ResetPasswordBloc resetBloc) {
    resetBloc.add(
      ResetPasswordButtonPressed(email: _emailTextEditingController.text),
    );
  }
}
