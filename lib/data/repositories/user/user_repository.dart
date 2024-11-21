import 'dart:developer';

import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/constants/pref_constants.dart';

class UserRepository extends BaseRepository {
  // Save onboarding status
  Future<void> saveOnboardingStatus(bool isOnboarding) async {
    try {
      // await AppPreferences.instance.saveBool(PrefConstants.kIsOnboarding, isOnboarding);
      log("Onboarding status saved: $isOnboarding");
    } catch (e) {
      log("Error saving onboarding status: $e");
    }
  }

  // Get onboarding status
  bool getOnboardingStatus() {
    try {
      // bool? isOnboarding = AppPreferences.instance.fetchBool(PrefConstants.kIsOnboarding);
      return  false;
    } catch (e) {
      log("Error fetching onboarding status: $e");
      return false; // Default to false if an error occurs
    }
  }

  // Save user token
  Future<void> saveUserToken(String token) async {
    try {
      // await AppPreferences.instance.saveString(PrefConstants.kToken, token);
      log("User token saved: $token");
    } catch (e) {
      log("Error saving user token: $e");
    }
  }

  // Get user token
  String? getUserToken() {
    try {
      return "AppPreferences.instance.fetchString(PrefConstants.kToken)";
    } catch (e) {
      log("Error fetching user token: $e");
      return null; // Return null if an error occurs
    }
  }

  // Clear all user data
  Future<void> clearUserData() async {
    try {
      // await AppPreferences.instance.resetValue(PrefConstants.kToken);
      // await AppPreferences.instance.resetValue(PrefConstants.kIsOnboarding);
      log("User data cleared");
    } catch (e) {
      log("Error clearing user data: $e");
    }
  }
}
