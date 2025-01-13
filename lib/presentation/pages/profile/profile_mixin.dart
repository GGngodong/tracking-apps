part of 'profile_page.dart';

mixin ProfileMixin on State<ProfilePage> {
  final DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  late TextEditingController emailTextEditingController;
  late TextEditingController firstNameTextEditingController;
  late TextEditingController lastNameTextEditingController;
  late TextEditingController birthdayTextEditingController;
  late TextEditingController genderTextEditingController;
  DateTime? _selectedDate;
  int? _selectedGender;

  @override
  void initState() {
    final ProfileState profileState = context.read<ProfileBloc>().state;
    emailTextEditingController = TextEditingController();
    firstNameTextEditingController = TextEditingController();
    lastNameTextEditingController = TextEditingController();
    birthdayTextEditingController = TextEditingController();
    genderTextEditingController = TextEditingController();

    if (profileState.user != null) {
      emailTextEditingController.text = profileState.user!.email;
      firstNameTextEditingController.text = profileState.user!.userName;
    }

    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    birthdayTextEditingController.dispose();
    genderTextEditingController.dispose();
    super.dispose();
  }

  void _listener(ProfileState state) {
    final ValidateSuccess validateSuccess = context.read<LoginBloc>().state as ValidateSuccess;
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    if (state is UpdateUserSuccess) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(Routes.navigation.path);
      }
    } else if (state is UpdateUserFailed) {
      profileBloc.add(SetUser(user: validateSuccess.user));
      AppHelper.alertDialogMessage(context: context, content: state.message ?? LocaleKeys.something_went_wrong.tr());
    }
  }

  bool _checkValues() {
    if (firstNameTextEditingController.text.trim().isEmpty) return false;
    if (lastNameTextEditingController.text.trim().isEmpty) return false;
    if (_selectedDate == null) return false;
    if (_selectedGender == null) return false;
    return true;
  }

  void _showLogOutDialog(BuildContext context, LoginBloc loginBloc) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(LocaleKeys.logout).tr(),
          content: const Text(LocaleKeys.ays_logout).tr(),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(LocaleKeys.no).tr(),
              onPressed: () {
                if (context.canPop()) context.pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text(LocaleKeys.yes).tr(),
              onPressed: () {
                loginBloc.add(const LogoutButtonPressed());
                context.go(Routes.login.path);
              },
            ),
          ],
        );
      },
    );
  }
}
