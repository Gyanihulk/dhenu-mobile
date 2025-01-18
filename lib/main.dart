import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/service/app_info.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
import 'package:dhenu_dharma/utils/providers/language_provider.dart';
import 'package:dhenu_dharma/views/app.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCi4YpFIV58HfoS3806T_aUO29KIMUxsbY",
      appId: "1:336065761387:android:2a1399f6db0d47e278612e",
      messagingSenderId: "336065761387",
      projectId: "dhenu-dharma",
      storageBucket: "dhenu-dharma.firebasestorage.app",
    ),
  );

  // Initialize shared preferences
  await AppPreferences.instance.initSharedPreferences();

  // Initialize repositories
  final languageRepository = LanguageRepository();

  // Initialize AuthProvider
  final authProvider = AuthProvider(languageRepository: languageRepository);

  // Load user data
  await authProvider.loadUserData();

  // Initialize LanguageProvider
  final languageProvider = LanguageProvider(
    languageRepository: languageRepository,
    authProvider: authProvider,
  );

  // Fetch languages (ensure proper initialization)
  await languageProvider.fetchLanguages();

  initDeepLinkListener();

  final appInfo = AppInfo();
  await appInfo.initialize();

  runApp(AppLocalizationState(
    child:MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => languageProvider),
      ],
      child: MyApp(authProvider: authProvider),
    ),
  ));
}

void initDeepLinkListener() {
  final appLinks = AppLinks();
  appLinks.uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      print('Received deep link: $uri');

      if (uri.scheme == 'gyanitech.dhenudharma' &&
          uri.host == 'payment-callback') {
        final invoiceId =
            uri.queryParameters['razorpay_invoice_id'] ?? "Unknown";
        final paymentId =
            uri.queryParameters['razorpay_payment_id'] ?? "Unknown";
        final status =
            uri.queryParameters['razorpay_invoice_status'] ?? "Unknown";

        if (status == 'paid') {
          print(
              'Payment successful! Invoice ID: $invoiceId, Payment ID: $paymentId');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Access navigator context to show SnackBar and navigate
            final context = MyApp.navigatorKey.currentContext!;

            // Show success SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Payment Successful! 🎉\nInvoice ID: $invoiceId\nPayment ID: $paymentId",
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 5),
              ),
            );

            // Navigate to the InitialScreen with home page selected
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const InitialScreen(pageIndex: 0)),
              (route) => false,
            );
          });
        } else {
          print('Payment failed. Status: $status');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final context = MyApp.navigatorKey.currentContext!;

            // Show failure SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Payment Failed. Please try again.\nInvoice ID: $invoiceId",
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );

            // Navigate to InitialScreen (optional, if required for failed payments)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const InitialScreen(pageIndex: 0)),
              (route) => false,
            );
          });
        }
      }
    }
  }, onError: (err) {
    print('Failed to handle deep link: $err');
  });
}
