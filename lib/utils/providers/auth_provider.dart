import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = AppPreferences.instance.isAuthenticated();
  UserModel? _user;
  String? _authToken;

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

