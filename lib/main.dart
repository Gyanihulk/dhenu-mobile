import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
import 'package:dhenu_dharma/utils/providers/language_provider.dart';
import 'package:dhenu_dharma/views/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCi4YpFIV58HfoS3806T_aUO29KIMUxsbY",
      appId: "1:336065761387:android:d97a9c3e51a7efc978612e",
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => languageProvider),
      ],
      child: MyApp(authProvider: authProvider),
    ),
  );
}
