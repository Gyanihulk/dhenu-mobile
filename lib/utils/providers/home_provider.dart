import 'package:dhenu_dharma/data/repositories/homePage/home_repository.dart';
import 'package:flutter/material.dart';

import 'package:dhenu_dharma/utils/providers/auth_provider.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepository homeRepository;
  final AuthProvider authProvider;

  // State variables
  Map<String, dynamic> _homeData = {};
  bool _isLoading = false;
  String _errorMessage = '';

  HomeProvider({required this.homeRepository, required this.authProvider});

  // Getters
  Map<String, dynamic> get homeData => _homeData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch Home Data
  Future<void> fetchHomeData() async {
    if (authProvider.authToken == null || authProvider.authToken!.isEmpty) {
      _errorMessage = 'Authentication token is missing. Please log in.';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      final fetchedData = await homeRepository.fetchHomeData(token: authProvider.authToken!);

      // Update state
      _homeData = fetchedData;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error fetching home data: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
