import 'package:dhenu_dharma/utils/common/url_launcher_util.dart';
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
  List<DateTime> selectedDates = []; // Store array of selected dates
  String? donationFrequency;
  String name = '';
  CowShedProvider({required this.repository, required this.authProvider});
  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateSelectedDates(List<DateTime> dates) {
    selectedDates = dates;
    notifyListeners();
  }

  // Method to update donation frequency
  void updateDonationFrequency(String frequency) {
    donationFrequency = frequency;
    notifyListeners();
  }

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
      "name": name,
      "selectedDates":
          selectedDates.map((date) => date.toIso8601String()).toList(),
      "donationFrequency": donationFrequency,
      "relatedFields":
          getRelatedFields(), // Helper function to get related fields
    };
  }

  Future<void> createDonation(BuildContext context) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final token = authProvider.authToken;
      if (token == null) {
        throw Exception('User is not authenticated');
      }

      final response =await repository.createDonation(
        token: token,
        cowShedId: selectedCowShedId!,
        donationType: donationType!,
        amount: amount,
        quantity: quantity,
        frequency: donationFrequency!,
        name: name,
        period: selectedDates,
      );

      print('Donation created successfully $response');
        final paymentLink = response['payment_link'] as String;

    // Use the existing launchURL function to open the payment link
    await launchURL(context, paymentLink);
    } catch (error) {
      errorMessage = error.toString();
      print('Error creating donation: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
