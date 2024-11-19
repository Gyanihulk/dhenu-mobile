// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class ChangeUsernameEvent extends LoginEvent {
  String username;
  ChangeUsernameEvent(this.username);

  @override
  List<Object> get props => [username];
}

final class ChangePasswordEvent extends LoginEvent {
  String password;
  ChangePasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}
@immutable
class LoginLoadEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginLoadEvent({
    required this.username,
    required this.password,
  });
}
