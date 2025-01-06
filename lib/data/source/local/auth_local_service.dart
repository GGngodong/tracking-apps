import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalAuthService {
  Future<bool> isLoggedIn();
}

class LocalAuthServiceImpl implements LocalAuthService {
  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}