import 'package:tracking_apps/common/shared_preferance_service.dart';

Future<bool> hasRole(String requiredRole) async {
  try {
    final userRole = await SharedPreferencesService.instance
        .getData<String>(PreferenceKey.userRole);

    return userRole != null && userRole == requiredRole;
  } catch (e) {
    print("Error checking role: $e");
    return false;
  }
}
