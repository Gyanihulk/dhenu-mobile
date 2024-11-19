import 'package:bloc/bloc.dart';
import 'package:dhenu_dharma/data/repositories/user/user_repository.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/screens/onboarding/onboarding_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  UserRepository userRepository;

  OnboardingBloc(this.userRepository) : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is OnboardingCompleteEvent) {
        userRepository.saveOnboardingStatus();
        CustomNavigator(context: event.context, screen: const LoginScreen())
            .pushReplacement();
      }

      if (event is OnboardingCheckStatusEvent) {
        bool onboardingStatus = userRepository.getOnboardingStatus();

        CustomNavigator(
          context: event.context,
          screen:
              onboardingStatus ? const LoginScreen() : const OnboardingScreen(),
        ).pushReplacement();
      }
    });
  }
}
