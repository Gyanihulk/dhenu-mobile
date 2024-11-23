import 'dart:convert';
import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/utils/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = AppPreferences.instance.isAuthenticated();
  UserModel? _user;
  String? _authToken;
  final LanguageRepository languageRepository;
   List<Map<String, dynamic>> languages = []; 
  AuthProvider({required this.languageRepository});
  bool get isAuthenticated => _isAuthenticated;
  UserModel? get user => _user;
  String? get authToken => _authToken;
  Future<void> loadUserData() async {
    final token = AppPreferences.instance.fetchToken();
    final userInfo = AppPreferences.instance.fetchUserInfo();

    if (token != null && userInfo != null) {
      _authToken = token;
      _user = UserModel.fromJson(jsonDecode(userInfo));
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<void> login(String token, UserModel user) async {
    _authToken = token;
    _user = user;
    _isAuthenticated = true;
    print('+++++++++++++++> SAving this info in provider ${user.toJson()} ');
    await AppPreferences.instance.saveToken(token);
    await AppPreferences.instance.saveUserInfo(jsonEncode(user.toJson()));
    await AppPreferences.instance.setAuthenticated(true);

    notifyListeners();
  }

  Future<void> initializeLanguages(LanguageProvider languageProvider) async {
    if (_authToken == null || _authToken!.isEmpty) {
      debugPrint('Token is null or empty. Cannot fetch languages.');
      return;
    }

    try {
      debugPrint('Fetching languages...');
      // Fetch languages using the LanguageProvider
      await languageProvider.fetchLanguages();
      debugPrint(
          'Languages fetched and updated in LanguageProvider: ${languageProvider.languages}');
    } catch (error) {
      debugPrint('Error fetching languages: $error');
    }
  }


  Future<void> logout() async {
    _authToken = null;
    _user = null;
    _isAuthenticated = false;

    await AppPreferences.instance.removeToken();
    await AppPreferences.instance.removeUserInfo();
    await AppPreferences.instance.setAuthenticated(false);

    notifyListeners();
  }
}
