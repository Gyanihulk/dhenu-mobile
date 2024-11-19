import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._();
  static final AppPreferences instance = AppPreferences._();

  late SharedPreferences preferences;

  Future<void> initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  bool containKey(String key) {
    return preferences.containsKey(key);
  }

  Future<void> saveString(String key, String value) async {
    await preferences.setString(key, value);
  }

  String? fetchString(String key) {
    return preferences.getString(key);
  }

  Future<void> saveInt(String key, int value) async {
    await preferences.setInt(key, value);
  }

  int? fetchInt(String key) {
    return preferences.getInt(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  bool? fetchBool(String key) {
    return preferences.getBool(key);
  }

  Future<void> resetValue(String key) async {
    await preferences.remove(key);
  }
}
