import 'package:dhenu_dharma/data/repositories/faqAndFeedback/help_and_feedback_repository.dart';
import 'package:flutter/material.dart';

import 'package:dhenu_dharma/utils/providers/auth_provider.dart';

class HelpAndFeedbackProvider with ChangeNotifier {
  final HelpAndFeedbackRepository helpAndFeedbackRepository;
  final AuthProvider authProvider;

  // State variables
  List<dynamic> _faqs = [];
  bool _isLoading = false;
  String _errorMessage = '';

  HelpAndFeedbackProvider({
    required this.helpAndFeedbackRepository,
    required this.authProvider,
  });

  // Getters
  List<dynamic> get faqs => _faqs;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch FAQs
  Future<void> fetchFAQs() async {
    if (authProvider.authToken == null || authProvider.authToken!.isEmpty) {
      _errorMessage = 'Authentication token is missing. Please log in.';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      final fetchedFAQs = await helpAndFeedbackRepository.fetchFAQs(
        token: authProvider.authToken!,
      );

      // Update state
      _faqs = fetchedFAQs;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error fetching FAQs: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Submit feedback
  Future<void> submitFeedback(int starCount, String note) async {
    if (authProvider.authToken == null || authProvider.authToken!.isEmpty) {
      _errorMessage = 'Authentication token is missing. Please log in.';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      await helpAndFeedbackRepository.submitFeedback(
        token: authProvider.authToken!,
        starCount: starCount,
        note: note,
      );

      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error submitting feedback: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
