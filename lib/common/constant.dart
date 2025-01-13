import 'package:easy_localization/easy_localization.dart';

class Constant {
  static final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
  static final DateTime nullDate = DateTime.parse('0001-01-01T00:00:00Z').toUtc();
  static final usernameRegex = RegExp(r'^[a-zA-Z0-9._]{3,20}$');
  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
}