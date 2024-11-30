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
    String? donationType;
  int quantity = 0;
  double amount = 0.0;
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

  // Update donation type
  void updateDonationType(String type) {
    donationType = type;
 
    notifyListeners(); // Notify listeners to update the UI
  }

  // Update quantity
  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
    notifyListeners();
  }

  // Update donation amount
  void updateAmount(double newAmount) {
    amount = newAmount;
    notifyListeners();
  }
  
   Map<String, dynamic> getDonationDetails() {
    return {
      "selectedCowShedId": selectedCowShedId,
      "donationType": donationType,
      "quantity": quantity,
      "amount": amount,
      "relatedFields": getRelatedFields(), // Helper function to get related fields
    };
  }

  /// Helper function to return related fields based on donation type
  dynamic getRelatedFields() {
    if (donationType == "Food") {
      return {
        "bagWeight": "50kg",
        "nutritionDetails": "High protein mix",
      };
    } else if (donationType == "Medicine") {
      return {
        "medicineType": "Antibiotics",
        "expiryDate": "12/2025",
      };
    } else if (donationType == "Doctors") {
      return {
        "doctorType": "Veterinary",
        "consultationHours": 4,
      };
    } else if (donationType == "Others") {
      return {
        "description": "Custom donation request",
      };
    }
    return null;
  }
}
