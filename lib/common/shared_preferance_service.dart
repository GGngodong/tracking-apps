// lib/common/shared_preferance_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();

  static final SharedPreferencesService instance = SharedPreferencesService._();

  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setData<T>(PreferenceKey key, T data) {
    if (data is String) {
      return _preferences.setString(key.name, data);
    }
    if (data is int) {
      return _preferences.setInt(key.name, data);
    }
    if (data is double) {
      return _preferences.setDouble(key.name, data);
    }
    if (data is bool) {
      return _preferences.setBool(key.name, data);
    }
    throw ArgumentError.value(
      data,
      'data',
      'Type ${data.runtimeType} not supported. Must be String/int/double/bool.',
    );
  }

  T? getData<T>(PreferenceKey key) {
    final Object? value = _preferences.get(key.name);
    if (value is T) {
      return value;
    }
    return null;
  }

  Future<bool> removeData(PreferenceKey key) {
    return _preferences.remove(key.name);
  }
}

enum PreferenceKey {
  authToken,
  userRole,
  useDeviceTheme,
  isDark,
  ;
}
