part of 'login_bloc.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}
