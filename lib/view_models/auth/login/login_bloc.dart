// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';
import 'package:dhenu_dharma/data/repositories/auth/auth_repository.dart';
import 'package:dhenu_dharma/data/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  String? username;
  String? password;

  LoginBloc({
    required this.authRepository,
    required this.userRepository,
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
        UserModel? user = await authRepository.login(
          username: username!,
          password: password!,
        );

        log("User: ${user?.data?.authToken}");

        if (user != null) {
          // Save token in UserRepository or SecureStorage
          userRepository.saveUserToken(user.data!.authToken!);
          emit(LoginSuccess(user)); // Emit success state with user data
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
