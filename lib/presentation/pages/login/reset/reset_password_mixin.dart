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
      AppHelper.showCustomAlertDialog(
        onPositivePressed: () => Navigator.pop(context),
        title: 'Password reset link successfully sent',
        context: context,
        content: 'Please check your email to reset your password',
      );
    } else if (state is ResetPasswordFailed) {
      AppHelper.showCustomAlertDialog(
        onPositivePressed: () => Navigator.pop(context),
        title: 'Failed to send password reset link',
        context: context,
        content: 'Please try again later',
      );
    }
  }

  void _submit(ResetPasswordBloc resetBloc) {
    resetBloc.add(
      ResetPasswordButtonPressed(email: _emailTextEditingController.text),
    );
  }
}
