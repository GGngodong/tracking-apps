import 'package:intl/intl.dart';

class Constant {
  static final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
  static final DateTime nullDate =
      DateTime.parse('0001-01-01T00:00:00Z').toUtc();

  static final usernameRegex = RegExp(r'^[a-zA-Z0-9._]{3,20}$');
  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final passwordRegex = RegExp(r'^.{8,}$');
  static final descriptionRegex = RegExp(r'^[a-zA-Z0-9._]{3,20}$');
  static final noPermitRegex =
      RegExp(r'^[A-Z]{1,2}\/\d{1,3}\/[A-Z]{1,2}\/\d{4}\/[\w-]+(?:\.\w+)*$');
  static final companyNameRegex =
      RegExp(r'^([A-Z]{2,}\s*)+((?:[A-Z]{2,}\s*)+)?$');
  static final noPermitMabesRegex =
      RegExp(r'^[A-Z]{1,2}\/\d{1,3}\/[A-Z]{1,2}\/\d{4}\/[\w-]+(?:\.\w+)*$');
}

class ValidatorHelper {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty!';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty!';
    }
    if (!Constant.emailRegex.hasMatch(value)) {
      return 'Invalid email format!';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty!';
    }
    if (!Constant.passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters!';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description cannot be empty!';
    }
    return null;
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name cannot be empty!';
    }
    if (!Constant.companyNameRegex.hasMatch(value)) {
      return 'Company name must be uppercase words';
    }
    return null;
  }

  static String? validatePermitNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Permit number cannot be empty!';
    }
    return null;
  }

  static String? validatePermitMabesNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mabes permit number cannot be empty!';
    }
    return null;
  }
}
