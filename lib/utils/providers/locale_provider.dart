import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default locale

  Locale get locale => _locale;

  LocaleProvider() {
    _loadSavedLocale(); // Load locale on initialization
  }

  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('locale') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  void setLocale(Locale locale) {
    print('Changing locale to local provider before compare: $_locale');
    if (_locale != locale) {
      print('Changing locale to local provider: ${locale.languageCode}');
      _locale = locale;
      notifyListeners();
    }
  }
}
