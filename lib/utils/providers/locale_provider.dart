import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();

    // Save the selected locale in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  Future<void> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('locale');

    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}
