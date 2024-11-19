// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class ChangeNameEvent extends RegisterEvent {
  String name;
  ChangeNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

final class ChangePhoneEvent extends RegisterEvent {
  String phone;
  ChangePhoneEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

final class ChangeEmailEvent extends RegisterEvent {
  String email;
  ChangeEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

final class ChangePasswordEvent extends RegisterEvent {
  String password;
  ChangePasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}

final class ChangeConfirmPasswordEvent extends RegisterEvent {
  String confirmPassword;
  ChangeConfirmPasswordEvent(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

final class RegisterLoadEvent extends RegisterEvent {
  BuildContext context;

  RegisterLoadEvent(this.context);
}
