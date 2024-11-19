import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/view_models/onboarding/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  handleOnboarding() {
    BlocProvider.of<OnboardingBloc>(context)
        .add(OnboardingCheckStatusEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ZoomIn(
          duration: const Duration(seconds: 2),
          child: Image.asset(
            AssetsConstants.logoImg,
            width: 250.w,
          ),
        ),
      ),
    );
  }
}
