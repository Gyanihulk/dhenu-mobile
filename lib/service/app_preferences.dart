import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._();
  static final AppPreferences instance = AppPreferences._();

  late SharedPreferences preferences;

  Future<void> initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
  // Save the selected language code
  Future<void> saveSelectedLanguage(String languageCode) async {
    await preferences.setString('selected_language', languageCode);
  }

  // Fetch the saved selected language code
  String? fetchSelectedLanguage() {
    return preferences.getString('selected_language');
  }
  // Save a string
  Future<void> saveString(String key, String value) async {
    await preferences.setString(key, value);
  }

  // Fetch a string
  String? fetchString(String key) {
    return preferences.getString(key);
  }

  // Save a boolean
  Future<void> saveBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  // Fetch a boolean
  bool? fetchBool(String key) {
    return preferences.getBool(key);
  }

  // Remove a value
  Future<void> resetValue(String key) async {
    await preferences.remove(key);
  }

  // Token Management
  Future<void> saveToken(String token) async {
    await preferences.setString('auth_token', token);
  }

  String? fetchToken() {
    return preferences.getString('auth_token');
  }

  Future<void> removeToken() async {
    await preferences.remove('auth_token');
  }

  // User Info Management
  Future<void> saveUserInfo(String userInfo) async {
    
    await preferences.setString('user_info', userInfo);
  }

  String? fetchUserInfo() {
    return preferences.getString('user_info');
  }

  Future<void> removeUserInfo() async {
    await preferences.remove('user_info');
  }

  // Authentication State Management
  Future<void> setAuthenticated(bool isAuthenticated) async {
    await preferences.setBool('is_authenticated', isAuthenticated);
  }

  bool isAuthenticated() {
    return preferences.getBool('is_authenticated') ?? false;
  }
}
