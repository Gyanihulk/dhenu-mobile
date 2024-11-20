import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/view_models/onboarding/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart'; // Import custom localization


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), handleOnboarding);
    super.initState();
  }

  void handleOnboarding() {
    BlocProvider.of<OnboardingBloc>(context)
        .add(OnboardingCheckStatusEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    // Access custom localization
    final localization = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            ZoomIn(
              duration: const Duration(seconds: 2),
              child: Image.asset(
                AssetsConstants.logoImg,
                width: 250.w,
              ),
            ),
            const SizedBox(height: 20),
            // Localized welcome text
            Text(
              localization!.translate('welcome'), // Localized text
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Dropdown for language selection
            
          ],
        ),
      ),
    );
  }
}
