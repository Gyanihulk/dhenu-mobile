import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/views/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.instance.initSharedPreferences();

  runApp(const App());
}
