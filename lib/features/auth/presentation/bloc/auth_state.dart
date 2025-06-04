part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LogOutLoading extends AuthState {}

class LogOutSuccess extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
