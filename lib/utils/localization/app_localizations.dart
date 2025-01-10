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

  // Suppress the "prefer_final_fields" warning because this map is updated dynamically.
  static final Map<String, Map<String, Map<String, String>>> _localizedStrings =
      {
    'en': {
      'home': {
        'welcome': 'Welcome to our website',
        'thank_you': 'Thank you for visiting!',
        'this': 'This',
      },
      // 'about': {
      //   'info': 'Welcome',
      //   'welcome': 'Welcome to our website',
      //   'thank_you': 'Thank you for visiting!',
      // },
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
      "navigation": {"home": "Home", "donate": "Donate", "profile": "Profile"},
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
        "userName": "Akansha Singh",
        "no_languages_available": "No languages available.",
        "language_updated": "Language updated to English."
      },
      'main': {
        'welcome': 'Welcome to our website',
        'thank_you': 'Thank you for visiting!',
        'this': 'This',
        'mission': 'Mission',
        "aboutUs": "About Us",
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
      "sending_code": "Sending verification code...",
      "empty_field_error": "Please enter a valid email or phone number.",
      "error_occurred":
          "An error occurred while sending the verification code.",
      "code_sent": "Verification code sent!",
      "error_sending_code":
          "Failed to send the verification code. Please try again.",
      "enter_new_password": "Set your new password.",
      "otp_hint": "Enter verification code",
      "new_password_hint": "Enter new password",
      "confirm_password_hint": "Confirm new password",
      "reset_button": "Reset Password",
      "invalid_password":
          "Password must be at least 8 characters long, contain a number, and a special character.",
      "password_mismatch": "Passwords do not match.",
      "resetting_password": "Resetting your password...",
      "success": "Password reset successfully!",
      "reset_failed": "Failed to reset password. Please try again."
      },
      "donate_screen": {
        "card1title": "Location",
        "card1subtitle": "Choose Gowshala near you",
        "card2title": "Type of Seva",
        "card2subtitle": "Choose what to donate",
        "card3title": "Donate Amount",
        "card3subtitle": "Choose how much to donate",
        "card4title": "Donation Frequency",
        "card4subtitle": "When do you want to donate",
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
        "cows": "cows",
        "complete_payment": "Pay",
        "complete_payment_details": "Confirm details and Pay",
        "past_date_error": "Past dates cannot be selected.",
        "single_date_error": "Only one date can be selected for {filter}.",
        "donation_in_name_of": "Donation in the name of",
        "total_donation": "Total Donation in this Month",
        "filter_single": "Single",
        "filter_daily": "Daily",
        "filter_weekly": "Weekly",
        "filter_monthly": "Monthly",
        "filter_yearly": "Yearly",
        "filter_custom": "Custom"
      },
      "mission": {
        "mission": "Mission",
        "missionDescription":
            "The mission of Dhenu Dharma is clear: to save our sacred cows and uphold our duty towards them. By joining this initiative, you become a part of something greater - a movement rooted in compassion and respect for all living beings.",
        "missionHighlight":
            "a movement rooted in compassion and respect for all living beings.",
        "contributionsMessage":
            "Your contributions, no matter how big or small, make a difference in the lives of these vulnerable animals.",
        "impact":
            "Your contributions, no matter how big or small, make a difference in the lives of these vulnerable animals.",
        "howWeWorkTitle": "How we work?",
        "howWeWorkDescription":
            "Your donation goes towards providing essential care for these cows, ensuring they have access to food, shelter, and medical attention. With Dhenu Dharma, you can rest assured that your contribution is making a tangible impact on the lives of these gentle creatures.",
        "howWeWorkHighlight": "food, shelter, and medical attention.",
        "whyTrustUsTitle": "Why trust us?",
        "whyTrustUsDescription":
            "Dhenu Dharma stands out with its unwavering transparency. With live feeds, witness shelter conditions and cow well-being firsthand. Detailed donation receipts provide peace of mind, ensuring full clarity on where your contributions are utilized.",
        "joinUsTitle":
            "Join Dhenu Dharma today, championing a movement to honor and care for our sacred cows.",
        "joinUsDescription":
            "Together, let's uphold values of compassion and kindness, ensuring they receive the respect they deserve.",
        "joinUsHighlight": "respect they deserve.",
        "description":
            "In the ancient teachings of Sanatan Dharma, cows hold a position of utmost reverence, often likened to that of a mother.",
        "problem":
            "Unfortunately, many of these sacred animals face a grim fate once they stop producing milk. They either end up slaughtered or left to wander helplessly. Dhenu Dharma aims to change this narrative.",
        "footerText1":
            "Join Dhenu Dharma today, championing a movement to honor and care for our sacred cows.",
        "footerText2":
            "Together, let's uphold values of compassion and kindness, ensuring they receive the respect they deserve.",
        "solution":
            "Dhenu Dharma introduces a platform designed to connect caring individuals with shelters that house non-lactating, vulnerable cows. Through this platform, users can contribute funds towards the welfare of these cows with unparalleled transparency."
      },
      "about": {
        "about_us_title": "About Us",
        "intro_main_title":
            "Dhenu Dharma, an NGO initiative, is dedicated to the care and prosperity of sacred cows",
        "intro_description":
            "Dhenu Dharma maintains hundreds of shelters for non-productive cows, ensuring their well-being, with proximity-based care. It emphasizes a seamless experience, prioritizing transparency. Donors can easily find nearby shelters and observe the conditions of supported cows via the platform.",
        "virtual_meetings_title": "Virtual Meetings",
        "virtual_meetings_description":
            "A unique aspect of Dhenu Dharma is its innovative approach to donor engagement. Donors have the opportunity to participate in virtual meetings, where they can observe how their contributions directly impact the welfare of the cows. This live interaction fosters a deeper connection between donors and the cause they support.",
        "transparency_title": "Transparency",
        "transparency_description":
            "Donors receive receipts for their donations, ensuring complete clarity on how their contributions are utilized. Also, donations made to Dhenu Dharma are eligible for tax exemption of up to 50% under section 80G of the Income Tax Act, providing added incentives to support the cause.",
        "topic_title": "Topic",
        "topic_description":
            "To further enhance donor engagement, Dhenu Dharma provides timely reminders and updates on the impact of donations. Through regular communication and content sharing, donors stay informed about the progress of the organization and the welfare of the cows they support.",
        "closing_description":
            "Dhenu Dharma is not just an NGO but a platform that facilitates meaningful connections between donors and the cause of cow welfare. With its emphasis on transparency, experience, and tax benefits, Dhenu Dharma empowers individuals to make a positive impact on the lives of sacred cows."
      },
      "contact": {
        "contact_us": "Contact Us",
        "get_in_touch": "Get in touch",
        "contact_us_message":
            "Please contact us via phone or email for any inquiries or assistance you need.",
        "phone_label": "(+91) 7755961959",
        "email_label": "contact@dhenudharmafoundation.org",
        "address_label":
            "Padtani Compound, Near Hotel Joshi Palace, Sangamner, Ahmednagar, Maharashtra, 422605",
        "follow_us_on": "Follow us on",
      },
      "share": {
        "title": "Share",
        "share_with_friends": "Share with friends",
        "description":
            "Share our app with friends and family to amplify our collective impact for a great cause.",
        "together_message":
            "Together, we can extend our reach and make a meaningful difference in the lives we aim to support.",
        "button_text": "Share",
        "share_message": "https://www.dhenudharmafoundation.org/"
      },
      "help_and_feedback": {
        "title": "Help & Feedback",
        "search_title": "How can we help you today?",
        "search_hint": "Search",
        "top_questions_title": "Top Questions",
        "default_question": "Default Question",
        "default_answer": "Default Answer",
        "feedback_title": "Feedback",
        "feedback_subtitle": "We appreciate your feedback",
        "feedback_description":
            "We are always looking for ways to improve your experience. Please tell us what you think.",
        "feedback_input_hint": "What can we do to improve your experience?",
        "submit_button": "Submit",
        "feedback_success": "Feedback submitted successfully!"
      },
      "my_donations_screen": {
        "title": "My Donations",
        "upcoming_donations": "Upcoming Donations",
        "past_donations": "Past Donations",
        "sort_by": "Sort by",
        "lifetime_donations": "Lifetime Donations",
        "total_donation": "Total Donation:",
        "number_of_donations": "No. of Donations:",
        "impact_highlights": "Impact Highlights:",
        "thank_you": "Thank You!",
        "thank_you_message": "For your generous donation",
        "impact_message":
            "It has significantly improved the lives and welfare of numerous cows under our care.",
        "donor": "Donor:",
        "date": "Date:",
        "time": "Time:",
        "donation_amount": "Donation Amount",
        "distance": "Distance",
        "contact": "Contact",
        "cancel_button": "Cancel",
        "cancel_confirmation": "Are you sure you want to cancel?",
        "receipts": "Receipts",
     "donation_receipt": "Donation Receipt",
  "appreciation_certificate": "Appreciation Certificate",
  "tax_exemption_certificate": "Tax Exemption Certificate"
      }
    },
    'hi': {
      'home': {
        'welcome': 'हमारी वेबसाइट पर आपका स्वागत है',
        'thank_you': 'आने के लिए धन्यवाद!',
        'this': 'यह',
      },
      // 'about': {
      //   'info': 'स्वागत है',
      //   'welcome': 'हमारी वेबसाइट पर आपका स्वागत है',
      //   'thank_you': 'आने के लिए धन्यवाद!',
      // },
      'login': {
        'welcome': 'धेनु धर्म में आपका स्वागत है',
        'login': 'लॉग इन करें',
        'phone_or_email': 'फ़ोन नंबर / ईमेल आईडी',
        'enter_phone_or_email': 'अपना फ़ोन नंबर या ईमेल आईडी दर्ज करें',
        'username_empty': 'यूज़रनेम या ईमेल खाली नहीं हो सकता',
        'password': 'पासवर्ड',
        'enter_password': 'अपना पासवर्ड दर्ज करें',
        'password_empty': 'पासवर्ड खाली नहीं हो सकता',
        'password_length_error': 'पासवर्ड कम से कम 8 अक्षरों का होना चाहिए',
        'forgot_password': 'पासवर्ड भूल गए?',
        'or': 'या',
        'dont_have_account': 'क्या आपके पास खाता नहीं है?',
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
        'confirm_password': 'पासवर्ड की पुष्टि करें',
        'enter_confirm_password': 'पासवर्ड की पुष्टि दर्ज करें',
        'sign_up_button': 'साइन अप करें',
        'or': 'या',
        'have_account': 'क्या आपके पास खाता है? साइन इन करें',
        'registration_successful': 'कृपया ईमेल/फोन पर ओटीपी जांचें।',
      },
      "otp_verification": {
        "title": "ओटीपी सत्यापन",
        "enter_otp": "अपने फ़ोन या ईमेल पर भेजा गया 6-अंकीय ओटीपी दर्ज करें",
        "otp_hint": "ओटीपी दर्ज करें",
        "verify_button": "ओटीपी सत्यापित करें",
        "invalid_otp": "अमान्य ओटीपी। कृपया पुनः प्रयास करें।",
        "success": "ओटीपी सफलतापूर्वक सत्यापित हुआ!",
        "failure": "ओटीपी सत्यापित करने में विफल। कृपया पुनः प्रयास करें।",
      },
      "navigation": {
        "home": "मुख्य पृष्ठ",
        "donate": "दान करें",
        "profile": "प्रोफ़ाइल",
      },
      "profile": {
        "signOut": "साइन आउट",
        "myDonations": "मेरे दान",
        "documents": "दस्तावेज़",
        "legal": "कानूनी",
        "helpFeedback": "सहायता और प्रतिक्रिया",
        "aboutUs": "हमारे बारे में",
        "share": "साझा करें",
        "contactUs": "हमसे संपर्क करें",
        "languages": "भाषाएं",
        "edit": "संपादित करें",
        "phoneNumber": "9876543210",
        "userName": "आकांक्षा सिंह",
        "no_languages_available": "कोई भाषा उपलब्ध नहीं है।",
        "language_updated": "भाषा हिंदी में अपडेट हो गई है।"
      },
      'main': {
        'welcome': 'हमारी वेबसाइट पर आपका स्वागत है',
        'thank_you': 'आने के लिए धन्यवाद!',
        'this': 'यह',
        'mission': 'मिशन',
        "aboutUs": "हमारे बारे में",
        'donate': 'दान करें',
        'authentication': 'प्रमाणीकरण',
        'receipts': 'रसीदें',
        'supporters_say_title': 'हमारे समर्थक क्या कहते हैं',
        'read_more': 'और पढ़ें',
        'about_us_title': 'हमारे बारे में',
        'about_us_description':
            'धेनु धर्म, एक एनजीओ पहल, कई गौशालाओं के माध्यम से पवित्र गायों की देखभाल करता है। आप निकटवर्ती गौशालाओं को देख सकते हैं, लाइव फीड और वर्चुअल मीटिंग के साथ पारदर्शी दान अनुभव का आनंद ले सकते हैं। दान 80G के तहत 50% तक कर-मुक्त हैं।',
        'know_more': 'अधिक जानें',
        'view_more': 'अधिक देखें',
        'real_time_metrics_title': 'वास्तविक समय के मीट्रिक्स',
        'total_donation': 'कुल दान',
        'total_gowshala': 'कुल गौशाला',
        'cows_helped': 'सहायता की गई गायें',
        'people_connected': 'जुड़े हुए लोग',
        'image_gallery': 'छवि गैलरी',
        'upcoming_donations_title': 'आगामी दान',
        'provide_title': 'हम क्या प्रदान करते हैं',
      },
      "forget_password": {
        "title": "पासवर्ड भूल गए",
      "enter_email_or_phone":
          "पासवर्ड रीसेट करने के लिए अपना ईमेल या फोन नंबर दर्ज करें।",
      "email_phone_hint": "ईमेल या फोन नंबर दर्ज करें",
      "send_code": "सत्यापन कोड भेजें",
      "sending_code": "सत्यापन कोड भेजा जा रहा है...",
      "empty_field_error": "कृपया एक मान्य ईमेल या फोन नंबर दर्ज करें।",
      "error_occurred": "सत्यापन कोड भेजते समय एक त्रुटि हुई।",
      "code_sent": "सत्यापन कोड भेज दिया गया है!",
      "error_sending_code":
          "सत्यापन कोड भेजने में विफल। कृपया पुनः प्रयास करें।",
      "enter_new_password": "अपना नया पासवर्ड सेट करें।",
      "otp_hint": "सत्यापन कोड दर्ज करें",
      "new_password_hint": "नया पासवर्ड दर्ज करें",
      "confirm_password_hint": "नया पासवर्ड कन्फर्म करें",
      "reset_button": "पासवर्ड रीसेट करें",
      "invalid_password":
          "पासवर्ड कम से कम 8 वर्ण लंबा होना चाहिए, जिसमें एक संख्या और एक विशेष अक्षर होना चाहिए।",
      "password_mismatch": "पासवर्ड मेल नहीं खाते।",
      "resetting_password": "आपका पासवर्ड रीसेट किया जा रहा है...",
      "success": "पासवर्ड सफलतापूर्वक रीसेट कर दिया गया है!",
      "reset_failed": "पासवर्ड रीसेट करने में विफल। कृपया पुनः प्रयास करें।"
      },
      "donate_screen": {
        "card1title": "स्थान",
        "card1subtitle": "अपने पास की गौशाला चुनें",
        "card2title": "सेवा का प्रकार",
        "card2subtitle": "क्या दान करना है चुनें",
        "card3title": "दान की राशि",
        "card3subtitle": "कितना दान करना चाहते हैं चुनें",
        "card4title": "दान की आवृत्ति",
        "card4subtitle": "आप कब दान करना चाहते हैं",
        "next": "आगे बढ़ें",
        "need_based": "जरूरत आधारित",
        "within_10_km": "10 किलोमीटर के भीतर",
        "nearest": "सबसे नजदीक",
        "most_review": "सबसे ज्यादा समीक्षाएं",
        "search_hint": "अपने पास की गौशाला खोजें",
        "back_button": "वापस जाएं",
        "donate": "दान करें",
        "action_label_quantity": "बैग की संख्या",
        "action_label_amount": "राशि दर्ज करें",
        "enter_amount": "एक राशि दर्ज करें",
        "food_details": "1 बैग की कीमत ₹500 है और 4 गायों को खिलाता है",
        "total_price": "कुल कीमत",
        "cows_fed": "गायों को खिलाना",
        "cows": "गायें",
        "complete_payment": "भुगतान करें",
        "complete_payment_details": "विवरण की पुष्टि करें और भुगतान करें",
        "past_date_error": "पिछली तारीखें चयनित नहीं की जा सकतीं।",
        "single_date_error":
            "{filter} के लिए केवल एक तारीख का चयन किया जा सकता है।",
        "donation_in_name_of": "दान का नाम",
        "total_donation": "इस महीने का कुल दान",
        "filter_single": "एकल",
        "filter_daily": "दैनिक",
        "filter_weekly": "साप्ताहिक",
        "filter_monthly": "मासिक",
        "filter_yearly": "वार्षिक",
        "filter_custom": "कस्टम"
      },
      "mission": {
        "mission": "मिशन",
        "missionDescription":
            "धेनु धर्म का मिशन स्पष्ट है: हमारी पवित्र गायों को बचाना और उनके प्रति हमारी जिम्मेदारी निभाना। इस पहल से जुड़कर, आप कुछ बड़ा करने का हिस्सा बनते हैं - एक ऐसा आंदोलन जो करुणा और सभी जीवों के प्रति सम्मान पर आधारित है।",
        "missionHighlight":
            "एक ऐसा आंदोलन जो करुणा और सभी जीवों के प्रति सम्मान पर आधारित है।",
        "contributionsMessage":
            "आपका योगदान, चाहे बड़ा हो या छोटा, इन कमजोर जानवरों के जीवन में बदलाव लाता है।",
        "impact":
            "आपका योगदान, चाहे बड़ा हो या छोटा, इन कमजोर जानवरों के जीवन में बदलाव लाता है।",
        "howWeWorkTitle": "हम कैसे काम करते हैं?",
        "howWeWorkDescription":
            "आपका दान इन गायों की देखभाल के लिए आवश्यक चीजों को उपलब्ध कराने में जाता है, जिसमें भोजन, आश्रय और चिकित्सा ध्यान शामिल है। धेनु धर्म के साथ, आप सुनिश्चित हो सकते हैं कि आपका योगदान इन कोमल प्राणियों के जीवन पर वास्तविक प्रभाव डाल रहा है।",
        "howWeWorkHighlight": "भोजन, आश्रय, और चिकित्सा ध्यान।",
        "whyTrustUsTitle": "हम पर भरोसा क्यों करें?",
        "whyTrustUsDescription":
            "धेनु धर्म अपनी अद्वितीय पारदर्शिता के साथ खड़ा है। लाइव फीड के साथ, शरण स्थलों की स्थिति और गायों की भलाई को सीधे देखें। विस्तृत दान रसीदें पूरी स्पष्टता प्रदान करती हैं कि आपका योगदान कहां उपयोग किया जा रहा है।",
        "joinUsTitle":
            "आज ही धेनु धर्म से जुड़ें, पवित्र गायों की देखभाल और सम्मान के लिए एक आंदोलन का समर्थन करें।",
        "joinUsDescription":
            "आइए, करुणा और दयालुता के मूल्यों को बनाए रखें, यह सुनिश्चित करते हुए कि उन्हें वह सम्मान मिले जो वे डिजर्व करती हैं।",
        "joinUsHighlight": "जो वे डिजर्व करती हैं।",
        "description":
            "सनातन धर्म की प्राचीन शिक्षाओं में, गायों को अत्यंत सम्मान का स्थान प्राप्त है, उन्हें अक्सर माँ के समान माना जाता है।",
        "problem":
            "दुर्भाग्य से, इन पवित्र जानवरों में से कई को दूध देना बंद करने के बाद भयानक स्थिति का सामना करना पड़ता है। या तो उनका वध कर दिया जाता है या वे बेबस भटकने के लिए छोड़ दी जाती हैं। धेनु धर्म इस कहानी को बदलने का लक्ष्य रखता है।",
        "footerText1":
            "आज ही धेनु धर्म से जुड़ें, पवित्र गायों की देखभाल और सम्मान के लिए एक आंदोलन का समर्थन करें।",
        "footerText2":
            "आइए, करुणा और दयालुता के मूल्यों को बनाए रखें, यह सुनिश्चित करते हुए कि उन्हें वह सम्मान मिले जो वे डिजर्व करती हैं।",
        "solution":
            "धेनु धर्म एक ऐसा प्लेटफ़ॉर्म प्रदान करता है जो देखभाल करने वाले व्यक्तियों को उन शरण स्थलों से जोड़ता है जहां गैर-लाभकारी, कमजोर गायें रखी जाती हैं। इस प्लेटफ़ॉर्म के माध्यम से, उपयोगकर्ता इन गायों की भलाई के लिए धन का योगदान कर सकते हैं, वह भी अद्वितीय पारदर्शिता के साथ।"
      },
      "about": {
        "about_us_title": "हमारे बारे में",
        "intro_main_title":
            "धेनु धर्म, एक एनजीओ पहल, पवित्र गायों की देखभाल और समृद्धि के लिए समर्पित है।",
        "intro_description":
            "धेनु धर्म सैकड़ों शरण स्थलों का प्रबंधन करता है जो गैर-उत्पादक गायों की भलाई सुनिश्चित करते हैं, साथ ही निकटता-आधारित देखभाल प्रदान करते हैं। यह एक सहज अनुभव पर जोर देता है, पारदर्शिता को प्राथमिकता देता है। दानदाता पास के शरण स्थलों को आसानी से ढूंढ सकते हैं और प्लेटफ़ॉर्म के माध्यम से समर्थित गायों की स्थिति देख सकते हैं।",
        "virtual_meetings_title": "वर्चुअल मीटिंग्स",
        "virtual_meetings_description":
            "धेनु धर्म की एक अनूठी विशेषता दानदाताओं को जोड़ने के लिए उसका अभिनव दृष्टिकोण है। दानदाता वर्चुअल मीटिंग्स में भाग लेने का अवसर प्राप्त करते हैं, जहां वे देख सकते हैं कि उनके योगदान का गायों की भलाई पर सीधा प्रभाव कैसे पड़ता है। यह लाइव इंटरैक्शन दानदाताओं और उनके समर्थन के कारण के बीच एक गहरा संबंध स्थापित करता है।",
        "transparency_title": "पारदर्शिता",
        "transparency_description":
            "दानदाताओं को उनके दान की रसीदें मिलती हैं, जिससे यह पूरी तरह स्पष्ट होता है कि उनका योगदान कैसे उपयोग किया गया। साथ ही, धेनु धर्म को किए गए दान आयकर अधिनियम की धारा 80G के तहत 50% तक कर छूट के लिए पात्र हैं, जिससे इस कारण को समर्थन देने के लिए अतिरिक्त प्रोत्साहन मिलता है।",
        "topic_title": "विषय",
        "topic_description":
            "दानदाता सहभागिता को और बढ़ाने के लिए, धेनु धर्म दान के प्रभाव पर समय पर रिमाइंडर और अपडेट प्रदान करता है। नियमित संचार और सामग्री साझा करने के माध्यम से, दानदाता संगठन की प्रगति और उन गायों की भलाई के बारे में सूचित रहते हैं जिन्हें वे समर्थन देते हैं।",
        "closing_description":
            "धेनु धर्म केवल एक एनजीओ नहीं है, बल्कि दानदाताओं और गाय कल्याण के कारण के बीच सार्थक संबंध बनाने वाला एक प्लेटफ़ॉर्म है। पारदर्शिता, अनुभव, और कर लाभ पर जोर देने के साथ, धेनु धर्म व्यक्तियों को पवित्र गायों के जीवन पर सकारात्मक प्रभाव डालने का अधिकार देता है।"
      },
      "contact": {
        "contact_us": "हमसे संपर्क करें",
        "get_in_touch": "संपर्क में रहें",
        "contact_us_message":
            "किसी भी पूछताछ या सहायता के लिए कृपया हमें फ़ोन या ईमेल के माध्यम से संपर्क करें।",
        "phone_label": "(+91) 7755961959",
        "email_label": "contact@dhenudharmafoundation.org",
        "address_label":
            "पडतानी कंपाउंड, होटल जोशी पैलेस के पास, संगमनेर, अहमदनगर, महाराष्ट्र, 422605",
        "follow_us_on": "हमसे जुड़ें",
      },
      "share": {
        "title": "साझा करें",
        "share_with_friends": "मित्रों के साथ साझा करें",
        "description":
            "हमारे ऐप को दोस्तों और परिवार के साथ साझा करें ताकि एक महान उद्देश्य के लिए हमारे सामूहिक प्रभाव को बढ़ाया जा सके।",
        "together_message":
            "हम मिलकर अपनी पहुंच को बढ़ा सकते हैं और उन जीवनों पर एक सार्थक अंतर ला सकते हैं जिनका हम समर्थन करना चाहते हैं।",
        "button_text": "साझा करें",
        "share_message": "https://www.dhenudharmafoundation.org/"
      },
      "help_and_feedback": {
        "title": "सहायता और प्रतिक्रिया",
        "search_title": "हम आपकी आज कैसे मदद कर सकते हैं?",
        "search_hint": "खोजें",
        "top_questions_title": "शीर्ष प्रश्न",
        "default_question": "डिफ़ॉल्ट प्रश्न",
        "default_answer": "डिफ़ॉल्ट उत्तर",
        "feedback_title": "प्रतिक्रिया",
        "feedback_subtitle": "हम आपकी प्रतिक्रिया की सराहना करते हैं",
        "feedback_description":
            "हम आपके अनुभव को बेहतर बनाने के तरीकों की तलाश में हमेशा रहते हैं। कृपया हमें बताएं कि आप क्या सोचते हैं।",
        "feedback_input_hint":
            "हम आपके अनुभव को बेहतर बनाने के लिए क्या कर सकते हैं?",
        "submit_button": "प्रस्तुत करें",
        "feedback_success": "प्रतिक्रिया सफलतापूर्वक सबमिट की गई!"
      },
      "my_donations_screen": {
        "title": "मेरे दान",
        "upcoming_donations": "आगामी दान",
        "past_donations": "पिछले दान",
        "sort_by": "इसके अनुसार क्रमबद्ध करें",
        "lifetime_donations": "आजीवन दान",
        "total_donation": "कुल दान:",
        "number_of_donations": "दान की संख्या:",
        "impact_highlights": "प्रभाव झलकियाँ:",
        "thank_you": "धन्यवाद!",
        "thank_you_message": "आपके उदार दान के लिए",
        "impact_message":
            "इसने हमारी देखभाल में कई गायों के जीवन और कल्याण में काफी सुधार किया है।",
        "donor": "दाता:",
        "date": "तारीख:",
        "time": "समय:",
        "donation_amount": "दान राशि",
        "distance": "दूरी",
        "contact": "संपर्क",
        "cancel_button": "रद्द करें",
        "cancel_confirmation": "क्या आप वाकई रद्द करना चाहते हैं?",
        "receipts": "रसीदें",
       "donation_receipt": "दान रसीद",
  "appreciation_certificate": "प्रशंसा प्रमाणपत्र",
  "tax_exemption_certificate": "कर छूट प्रमाणपत्र"
      }
    }
  };

  // Method to get translation for a specific key
  String translate(String key) {
    // debugPrint('Translating key: $key for locale: ${locale.languageCode}');
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

  static void updateLocalizedStrings(
      Map<String, dynamic> newStrings, Locale locale) {
    // Convert `Map<String, dynamic>` to `Map<String, Map<String, String>>`
    Map<String, Map<String, String>> formattedStrings =
        newStrings.map((key, value) {
      if (value is Map) {
        return MapEntry(
          key,
          value.map((innerKey, innerValue) {
            if (innerValue is String) {
              return MapEntry(innerKey, innerValue);
            } else {
              throw Exception('Invalid value type in inner map: $innerValue');
            }
          }),
        );
      } else {
        throw Exception('Invalid value type in main map: $value');
      }
    });

    // Update localized strings for the specified locale
    _localizedStrings[locale.languageCode] = formattedStrings;
    print("updated the map $formattedStrings");
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
