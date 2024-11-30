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
      },
      'main': {
        'welcome': 'Welcome to our website',
        'thank_you': 'Thank you for visiting!',
        'this': 'This',
        'mission': 'Mission',
        'donate': 'Donate',
        'authentication': 'Authentication',
        'receipts': 'Receipts',
        'supporters_say_title': 'What our supporters say',
        'read_more': 'Read more',
        'about_us_title': 'About Us',
        'about_us_description':
            'Dhenu Dharma, an NGO initiative, cares for sacred cows through numerous shelters. You can view nearby shelters, enjoy transparent donation experience with live feed and virtual meetings. Donations are tax-exempt up to 50% under 80G.',
        'know_more': 'Know More',
        'view_more': 'View More',
        'real_time_metrics_title': 'Real Time Metrics',
        'total_donation': 'Total Donation',
        'total_gowshala': 'Total Gowshala',
        'cows_helped': 'Cows Helped',
        'people_connected': 'People Connected',
        'image_gallery': 'Image Gallery',
        'upcoming_donations_title': 'Upcoming Donations',
        'provide_title': 'What We Provide',
      },
      "forget_password": {
        "title": "Forgot Password",
        "enter_email_or_phone":
            "Enter your email or phone number to reset your password.",
        "email_phone_hint": "Enter email or phone number",
        "send_code": "Send Verification Code",
        "empty_field_error": "Please enter a valid email or phone number.",
        "code_sent": "Verification code sent!",
        "enter_otp": "Enter the verification code sent to your email/phone.",
        "otp_hint": "Enter verification code",
        "verify_code": "Verify Code",
        "invalid_otp": "Please enter a valid 6-digit OTP.",
        "otp_verified": "OTP Verified!",
        "enter_new_password": "Set your new password.",
        "new_password_hint": "Enter new password",
        "confirm_password_hint": "Confirm new password",
        "reset_button": "Reset Password",
        "password_mismatch": "Passwords do not match or are empty.",
        "success": "Password reset successfully!"
      },
      "donate_screen": {
        "card1title": "Location",
        "card1subtitle": "Choose Gowshala near you",
        "card2title": "Type of Seva",
        "card2subtitle": "Choose what to donate",
        "card3title": "Donate Amount",
        "card3subtitle": "Choose how much to donate",
        "next": "Next",
        "need_based": "Need Based",
        "within_10_km": "Within 10 km",
        "nearest": "Nearest",
        "most_review": "Most Review",
        "search_hint": "Search Gowshala near you",
        "back_button": "Back",
        "donate": "Donate",
        "action_label_quantity": "QUANTITY OF BAGS",
        "action_label_amount": "ENTER AMOUNT",
        "enter_amount": "Enter an amount",
        "food_details": "1 bag costs ₹500 & feeds 4 cows",
        "total_price": "Total Price",
        "cows_fed": "Feeding",
        "cows":"cows"
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
      },
      'main': {
        'welcome': 'आपका हमारी वेबसाइट पर स्वागत है',
        'thank_you': 'आपके आने का धन्यवाद!',
        'this': 'यह',
        'mission': 'मिशन',
        'donate': 'दान करें',
        'authentication': 'प्रमाणीकरण',
        'receipts': 'रसीदें',
        'supporters_say_title': 'हमारे समर्थक क्या कहते हैं',
        'read_more': 'और पढ़ें',
        'about_us_title': 'हमारे बारे में',
        'about_us_description':
            'धेनु धर्म, एक एनजीओ पहल, पवित्र गायों की देखभाल करता है। आप पास के शेल्टर देख सकते हैं, लाइव फीड और वर्चुअल मीटिंग के साथ पारदर्शी दान का अनुभव कर सकते हैं। दान 80G के तहत 50% तक कर-मुक्त हैं।',
        'know_more': 'और जानें',
        'view_more': 'और देखें',
        'real_time_metrics_title': 'रीयल टाइम मेट्रिक्स',
        'total_donation': 'कुल दान',
        'total_gowshala': 'कुल गौशाला',
        'cows_helped': 'सहायता प्राप्त गायें',
        'people_connected': 'लोग जुड़े',
        'upcoming_donations_title': 'आगामी दान',
        'image_gallery': "छवि गैलरी",
        'provide_title': 'हम क्या प्रदान करते हैं',
      },
      "forget_password": {
        "title": "पासवर्ड भूल गए",
        "enter_email_or_phone":
            "अपना ईमेल या फोन नंबर दर्ज करें ताकि हम आपके पासवर्ड को रीसेट कर सकें।",
        "email_phone_hint": "ईमेल या फोन नंबर दर्ज करें",
        "send_code": "सत्यापन कोड भेजें",
        "empty_field_error": "कृपया सही ईमेल या फोन नंबर दर्ज करें।",
        "code_sent": "सत्यापन कोड भेजा गया!",
        "enter_otp": "अपने ईमेल/फोन पर भेजा गया सत्यापन कोड दर्ज करें।",
        "otp_hint": "सत्यापन कोड दर्ज करें",
        "verify_code": "कोड सत्यापित करें",
        "invalid_otp": "कृपया सही 6-अंकों का कोड दर्ज करें।",
        "otp_verified": "ओटीपी सत्यापित हो गया!",
        "enter_new_password": "अपना नया पासवर्ड सेट करें।",
        "new_password_hint": "नया पासवर्ड दर्ज करें",
        "confirm_password_hint": "पासवर्ड की पुष्टि करें",
        "reset_button": "पासवर्ड रीसेट करें",
        "password_mismatch": "पासवर्ड मेल नहीं खाते या खाली हैं।",
        "success": "पासवर्ड सफलतापूर्वक रीसेट हो गया!"
      },
      "donate_screen": {
        "title": "स्थान",
        "subtitle": "अपने पास की गौशाला चुनें",
        "next": "आगे बढ़ें",
        "need_based": "जरूरत आधारित",
        "within_10_km": "10 किमी के भीतर",
        "nearest": "निकटतम",
        "most_review": "सर्वाधिक समीक्षा",
        "search_hint": "अपने पास की गौशाला खोजें",
        "back_button": "वापस",
        "donate": "दान",
        "action_label_quantity": "बैग की मात्रा",
        "action_label_amount": "राशि दर्ज करें",
        "enter_amount": "राशि दर्ज करें",
        "food_details": "1 बैग की कीमत ₹500 है और 4 गायों को खिलाता है",
        "total_price": "कुल कीमत",
        "cows_fed": "",
        "cows":"गायों को खिला रहे हैं"
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
    // debugPrint('Loading AppLocalizations for locale: ${locale.languageCode}');
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
