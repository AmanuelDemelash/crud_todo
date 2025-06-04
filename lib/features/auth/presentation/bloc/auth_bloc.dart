import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../main.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse res = await supabase.auth.signInWithPassword(
          email: event.email.trim(),
          password: event.password.trim(),
        );
        emit(AuthSuccess(res.user!));
      } on AuthException catch (error) {
        emit(AuthFailure(error.message));
      } catch (error) {
        emit(AuthFailure('Unexpected error occurred'));
      }
    });

    on<SignUpEVent>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse res = await supabase.auth.signUp(
          email: event.email.trim(),
          password: event.password.trim(),
        );
        emit(AuthSuccess(res.user!));
      } on AuthException catch (error) {
        emit(AuthFailure(error.message));
      } catch (error) {
        emit(AuthFailure('Unexpected error occurred'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(LogOutLoading());
      try {
        await supabase.auth.signOut();
        emit(LogOutSuccess());
      } on AuthException catch (error) {
        emit(AuthFailure(error.message));
      } catch (error) {
        emit(AuthFailure('Unexpected error occurred'));
      }
    });
  }
}
