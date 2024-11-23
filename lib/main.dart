import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
import 'package:dhenu_dharma/views/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure Widgets are initialized
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
  // Initialize SharedPreferences
  await AppPreferences.instance.initSharedPreferences();

  // Initialize AuthProvider
  final authProvider = AuthProvider();
  await authProvider.loadUserData(); // Load saved user data and auth state

  runApp(MyApp(authProvider: authProvider));
}
