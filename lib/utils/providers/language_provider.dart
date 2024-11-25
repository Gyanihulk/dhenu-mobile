import 'package:flutter/material.dart';
import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';

class LanguageProvider with ChangeNotifier {
  final LanguageRepository languageRepository;
  final AuthProvider authProvider;

  // State variables
  List<Map<String, dynamic>> _languages = [];
  bool _isLoading = false;
  String _errorMessage = '';

  LanguageProvider({required this.languageRepository, required this.authProvider});

  // Getters
  List<Map<String, dynamic>> get languages => _languages;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch Languages
  Future<void> fetchLanguages() async {
    if (authProvider.authToken == null || authProvider.authToken!.isEmpty) {
      _errorMessage = 'Authentication token is missing. Please log in.';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      final fetchedLanguages = await languageRepository.fetchLanguages(token: authProvider.authToken!);

      // Update state
      _languages = fetchedLanguages;
print('saving languages in provider $_languages');
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error fetching languages: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
