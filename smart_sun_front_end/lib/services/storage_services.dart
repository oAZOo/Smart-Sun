import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveList(String key, List<String> list) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(key, list);
  }

  static readList(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key);
  }
}
