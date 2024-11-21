import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
import 'package:dhenu_dharma/views/app.dart';
import 'package:flutter/material.dart';


void main() async {
  // Ensure Widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await AppPreferences.instance.initSharedPreferences();

  // Initialize AuthProvider
  final authProvider = AuthProvider();
  await authProvider.loadUserData(); // Load saved user data and auth state

  runApp(MyApp(authProvider: authProvider));
}