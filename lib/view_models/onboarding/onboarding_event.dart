// ignore_for_file: must_be_immutable

part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

final class OnboardingCompleteEvent extends OnboardingEvent {
  BuildContext context;
  OnboardingCompleteEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class OnboardingCheckStatusEvent extends OnboardingEvent {
  BuildContext context;
  OnboardingCheckStatusEvent(this.context);

  @override
  List<Object> get props => [context];
}
