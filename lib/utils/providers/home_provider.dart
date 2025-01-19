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
  List<Map<String, dynamic>> _notifications = [];
  List<Map<String, dynamic>> get notifications => _notifications;

  HomeProvider({required this.homeRepository, required this.authProvider});

  // Getters
  Map<String, dynamic> get homeData => _homeData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Future<void> fetchNotifications() async {
    if (authProvider.authToken == null || authProvider.authToken!.isEmpty) {
      _errorMessage = 'Authentication token is missing. Please log in.';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      if (authProvider.authToken == null || authProvider.authToken!.isEmpty) {
        _errorMessage = 'Authentication token is missing. Please log in.';
        notifyListeners();
        return;
      }
      final userId = authProvider
          .user!.id; // Add `userId` in AuthProvider if not already present
      final fetchedNotifications = await homeRepository.fetchNotifications(
        token: authProvider.authToken!,
        userId: userId!,
      );

      // Update state
      _notifications = fetchedNotifications;
      print(" list of notifications $_notifications");
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error fetching notifications: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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

      final fetchedData =
          await homeRepository.fetchHomeData(token: authProvider.authToken!);

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
