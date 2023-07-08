import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) {
    if (value is String) return sharedPreferences!.setString(key, value);
    if (value is int) return sharedPreferences!.setInt(key, value);
    if (value is bool) return sharedPreferences!.setBool(key, value);
    return sharedPreferences!.setDouble(key, value);
  }

  static dynamic getBoolData({
    required String key,
  }) {
    return sharedPreferences!.get(key) ?? false;
  }

  static dynamic getStringData({
    required String key,
  }) {
    return sharedPreferences!.get(key) ?? '';
  }

 static Future<bool> deleteData(String key) {
    return sharedPreferences!.remove(key);
  }



}
