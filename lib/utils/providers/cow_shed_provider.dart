import 'package:flutter/material.dart';
import 'package:dhenu_dharma/data/repositories/cowshed/cow_shed_repository.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';

class CowShedProvider with ChangeNotifier {
  final CowShedRepository repository;
  AuthProvider authProvider;

  List<dynamic> cowSheds = [];
  bool isLoading = false;
  String errorMessage = '';
int? selectedCowShedId;
  CowShedProvider({required this.repository, required this.authProvider});
  
  void updateAuthProvider(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    notifyListeners(); // Notify listeners to react to the change
  }
  Future<void> fetchCowSheds({
    String sortBy = 'name',
    String dir = 'DESC',
    int perPage = 5,
    String search = '',
    String filter = '',
    required double currentLatitude,
    required double currentLongitude,
    int distance = 15,
  }) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final token = authProvider.authToken; // Fetch token from AuthProvider
      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response = await repository.fetchCowSheds(
        token: token,
        sortBy: sortBy,
        dir: dir,
        perPage: perPage,
        search: search,
        filter: filter,
        currentLatitude: currentLatitude,
        currentLongitude: currentLongitude,
        distance: distance,
      );

      cowSheds = response['data'] ?? [];
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
   void updateSelectedCowShedId(int id) {
    selectedCowShedId = id;
    notifyListeners(); // Notify listeners to update the UI
  }
}
