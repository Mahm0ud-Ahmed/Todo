import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class StoragePref {
  static SharedPreferences _preferences;

  static Future<SharedPreferences> getInstance() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static dynamic getValue(String key) {
    return _preferences.get(key);
  }

  static Future<bool> setValue(String key, dynamic value) async {
    switch (value.runtimeType) {
      case String:
        return _preferences.setString(key, value.toString());
      case int:
        return _preferences.setInt(key, value as int);
      case double:
        return _preferences.setDouble(key, value as double);
      case bool:
        return _preferences.setBool(key, value as bool);
    }
    return false;
  }

  static Future<bool> removeValue(String key) async {
    final bool result = await _preferences.remove(key);
    return result;
  }

  static Future<bool> clearStorage() async {
    final bool result = await _preferences.clear();
    return result;
  }
}
