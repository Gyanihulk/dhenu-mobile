// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';
import 'package:dhenu_dharma/data/repositories/auth/auth_repository.dart';
import 'package:dhenu_dharma/data/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final AuthProvider authProvider; // Add AuthProvider

  String? username;
  String? password;

  LoginBloc({
    required this.authRepository,
    required this.userRepository,
    required this.authProvider, // Inject AuthProvider
  }) : super(const LoginInitial()) {
    // Handle username change
    on<ChangeUsernameEvent>((event, emit) {
      username = event.username;
    });

    // Handle password change
    on<ChangePasswordEvent>((event, emit) {
      password = event.password;
    });

    // Handle login event
    on<LoginLoadEvent>((event, emit) async {
      emit(const LoginLoading()); // Emit loading state
      try {
        // Call login repository
        UserModel? user = await authRepository.login(
          username: username!,
          password: password!,
        );

        if (user != null) {
          print("user from bloc");
          print(user);
          // Save token and user data in AuthProvider
          await authProvider.login(user.authToken!, user);

          // Emit success state
          emit(LoginSuccess(user));
        } else {
          emit(const LoginError("Failed to login. Please try again."));
        }
      } catch (e) {
        log("Error (Login Bloc): $e");
        emit(LoginError(e.toString())); // Emit error state with exception
      }
    });
  }
}
