// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dhenu_dharma/data/repositories/auth/auth_repository.dart';
import 'package:dhenu_dharma/views/widgets/custom_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthRepository authRepository;

  String? name;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      if (event is ChangeNameEvent) {
        name = event.name;
      }

      if (event is ChangePhoneEvent) {
        phone = event.phone;
      }

      if (event is ChangeEmailEvent) {
        email = event.email;
      }

      if (event is ChangePasswordEvent) {
        password = event.password;
      }

      if (event is ChangeConfirmPasswordEvent) {
        confirmPassword = event.confirmPassword;
      }

      if (event is RegisterLoadEvent) {
        onRegister(event, emit);
      }
    });
  }

  Future<void> onRegister(
      RegisterLoadEvent event, Emitter<RegisterState> emit) async {
    FocusScope.of(event.context).requestFocus(FocusNode());

    CustomDialog.showLoader(event.context);
    try {
      await authRepository.register(
          name: name!, phone: phone!, email: email!, password: password!);
    } catch (e) {
      log("Error (Register Bloc): $e");
      Navigator.pop(event.context);
      CustomDialog.showErrorDialog(event.context, e);
    }
  }
}
