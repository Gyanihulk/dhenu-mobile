import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale) {
    debugPrint(
        'AppLocalizations initialized with locale: ${locale.languageCode}');
  }

  // Factory to access the current localization
  static AppLocalizations? of(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    debugPrint(
        'AppLocalizations.of called for locale: ${localizations?.locale.languageCode}');
    return localizations;
  }

  static const Map<String, Map<String, Map<String, String>>> _localizedStrings =
      {
    'en': {
      'home': {
        'welcome': 'Welcome to our website',
        'thank_you': 'Thank you for visiting!',
        'this': 'This',
      },
      'about': {
        'info': 'Welcome',
        'welcome': 'Welcome to our website',
        'thank_you': 'Thank you for visiting!',
      },
      'login': {
        'welcome': 'Welcome to Dhenu Dharma',
        'login': 'Login',
        'phone_or_email': 'Phone Number / Email ID',
        'enter_phone_or_email': 'Enter your Phone Number or Email ID',
        'username_empty': 'Username or email cannot be empty',
        'password': 'Password',
        'enter_password': 'Enter your password',
        'password_empty': 'Password cannot be empty',
        'password_length_error': 'Password must be at least 8 characters long',
        'forgot_password': 'Forgot Password?',
        'or': 'OR',
        'dont_have_account': "Don't have an account?",
        'sign_up': 'Sign Up',
      },
      'signup': {
        'title': 'Sign Up',
        'first_name': 'First Name',
        'enter_first_name': 'Enter your First Name',
        'last_name': 'Last Name',
        'enter_last_name': 'Enter your Last Name',
        'phone_number': 'Phone Number',
        'enter_phone_number': 'Enter your phone number',
        'email_id': 'Email ID',
        'enter_email_id': 'Enter your Email ID',
        'password': 'Password',
        'enter_password': 'Enter your password',
        'confirm_password': 'Confirm Password',
        'enter_confirm_password': 'Enter confirm password',
        'sign_up_button': 'Sign Up',
        'or': 'OR',
        'have_account': 'Already have an account? Sign in',
        'registration_successful': 'Please check email/phone for OTP.'
      },
      "otp_verification": {
        "title": "Verify OTP",
        "enter_otp": "Enter the 6-digit OTP sent to your phone or email",
        "otp_hint": "Enter OTP",
        "verify_button": "Verify OTP",
        "invalid_otp": "Invalid OTP. Please try again.",
        "success": "OTP Verified Successfully!",
        "failure": "Failed to verify OTP. Please try again."
      },
      "navigation": {"home": "HOME", "donate": "DONATE", "profile": "PROFILE"},
      "profile": {
        "signOut": "Sign Out",
        "myDonations": "My Donations",
        "documents": "Documents",
        "legal": "Legal",
        "helpFeedback": "Help & Feedback",
        "aboutUs": "About Us",
        "share": "Share",
        "contactUs": "Contact Us",
        "languages": "Languages",
        "edit": "Edit",
        "phoneNumber": "9876543210",
        "userName": "Akansha Singh"
      }
    },
    'hi': {
      'home': {
        'welcome': 'आपका हमारी वेबसाइट पर स्वागत है',
        'thank_you': 'आपके आने का धन्यवाद!',
        'this': 'यह',
      },
      'about': {
        'info': 'स्वागत',
        'welcome': 'आपका हमारी वेबसाइट पर स्वागत है',
        'thank_you': 'आपके आने का धन्यवाद!',
      },
      'login': {
        'welcome': 'धेनु धर्म में आपका स्वागत है',
        'login': 'लॉगिन',
        'phone_or_email': 'फ़ोन नंबर / ईमेल आईडी',
        'enter_phone_or_email': 'अपना फ़ोन नंबर या ईमेल आईडी दर्ज करें',
        'username_empty': 'उपयोगकर्ता नाम या ईमेल खाली नहीं हो सकता',
        'password': 'पासवर्ड',
        'enter_password': 'अपना पासवर्ड दर्ज करें',
        'password_empty': 'पासवर्ड खाली नहीं हो सकता',
        'password_length_error': 'पासवर्ड कम से कम 8 वर्ण लंबा होना चाहिए',
        'forgot_password': 'पासवर्ड भूल गए?',
        'or': 'या',
        'dont_have_account': 'क्या आपका खाता नहीं है?',
        'sign_up': 'साइन अप करें',
      },
      'signup': {
        'title': 'साइन अप करें',
        'first_name': 'पहला नाम',
        'enter_first_name': 'अपना पहला नाम दर्ज करें',
        'last_name': 'अंतिम नाम',
        'enter_last_name': 'अपना अंतिम नाम दर्ज करें',
        'phone_number': 'फ़ोन नंबर',
        'enter_phone_number': 'अपना फ़ोन नंबर दर्ज करें',
        'email_id': 'ईमेल आईडी',
        'enter_email_id': 'अपना ईमेल आईडी दर्ज करें',
        'password': 'पासवर्ड',
        'enter_password': 'अपना पासवर्ड दर्ज करें',
        'confirm_password': 'पासवर्ड की पुष्टि कीजिये',
        'enter_confirm_password': 'पुष्टि पासवर्ड दर्ज करें',
        'sign_up_button': 'साइन अप करें',
        'or': 'या',
        'have_account': 'पहले से खाता है? साइन इन करें',
        'registration_successful': 'Please check email/phone for OTP.'
      },
      "otp_verification": {
        "title": "Verify OTP",
        "enter_otp": "Enter the 6-digit OTP sent to your phone or email",
        "otp_hint": "Enter OTP",
        "verify_button": "Verify OTP",
        "invalid_otp": "Invalid OTP. Please try again.",
        "success": "OTP Verified Successfully!",
        "failure": "Failed to verify OTP. Please try again."
      },
      "navigation": {"home": "होम", "donate": "दान", "profile": "प्रोफ़ाइल"},
      "profile": {
        "signOut": "साइन आउट",
        "myDonations": "मेरे दान",
        "documents": "दस्तावेज़",
        "legal": "कानूनी",
        "helpFeedback": "सहायता और प्रतिक्रिया",
        "aboutUs": "हमारे बारे में",
        "share": "साझा करें",
        "contactUs": "संपर्क करें",
        "languages": "भाषाएँ",
        "edit": "संपादित करें",
        "phoneNumber": "9876543210",
        "userName": "अकांशा सिंह"
      }
    },
  };

  // Method to get translation for a specific key
  String translate(String key) {
    var keys = key.split('.');
    Map<String, dynamic>? currentMap = _localizedStrings[locale.languageCode];

    for (int i = 0; i < keys.length; i++) {
      var k = keys[i];
      if (currentMap![k] is Map<String, dynamic>) {
        currentMap = currentMap[k];
      } else if (currentMap[k] is String) {
        return currentMap[k];
      } else {
        // Fallback if the key does not exist
        debugPrint('Key not found: $key, returning default key');
        return key;
      }
    }

    debugPrint('Incorrect or incomplete key provided: $key');
    return key; // Fallback for incorrectly specified keys
  }

  // Method to change the locale dynamically
  static void changeLocale(BuildContext context, Locale locale) {
    debugPrint('Attempting to change locale to: ${locale.languageCode}');
    _AppLocalizationState? state =
        context.findAncestorStateOfType<_AppLocalizationState>();
    if (state != null) {
      debugPrint('Locale updated to: ${locale.languageCode}');
      state.updateLocale(locale);
    } else {
      debugPrint('Failed to find AppLocalizationState. Locale change aborted.');
    }
  }

  // Localization delegate
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final supported = ['en', 'hi'].contains(locale.languageCode);
    debugPrint('Locale ${locale.languageCode} is supported: $supported');
    return supported;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    debugPrint('Loading AppLocalizations for locale: ${locale.languageCode}');
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    debugPrint('Checking if reload is needed.');
    return false;
  }
}

class AppLocalizationState extends StatefulWidget {
  final Widget child;

  const AppLocalizationState({Key? key, required this.child}) : super(key: key);

  @override
  _AppLocalizationState createState() => _AppLocalizationState();
}

class _AppLocalizationState extends State<AppLocalizationState> {
  Locale _locale = const Locale('en');

  void updateLocale(Locale locale) {
    debugPrint(
        'updateLocale called. Changing locale to: ${locale.languageCode}');
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Building AppLocalizationState with locale: ${_locale.languageCode}');
    return Localizations(
      locale: _locale,
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      child: widget.child,
    );
  }
}
