import 'dart:developer';

import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/constants/pref_constants.dart';

class UserRepository extends BaseRepository {
  void saveOnboardingStatus() {
    AppPreferences.instance.saveBool(PrefConstants.kIsOnboarding, true);
  }

  bool getOnboardingStatus() {
    bool? isOnboarding =
        AppPreferences.instance.fetchBool(PrefConstants.kIsOnboarding);

    if (isOnboarding != null) {
      return true;
    }
    return false;
  }

  void saveUserToken(String token) {
    log("User Token Saved: $token");
    AppPreferences.instance.saveString(PrefConstants.kToken, token);
  }

  String? getUserToken() {
    return AppPreferences.instance.fetchString(PrefConstants.kToken);
  }
}
