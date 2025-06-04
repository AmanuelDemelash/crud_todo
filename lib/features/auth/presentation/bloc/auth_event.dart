part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpEVent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEVent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}
