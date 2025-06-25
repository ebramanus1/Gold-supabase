import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Events
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class LogoutRequested extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId;

  AuthAuthenticated({required this.userId});
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse response = await Supabase.instance.client.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );
        if (response.user != null) {
          emit(AuthAuthenticated(userId: response.user!.id));
        } else {
          emit(AuthError(message: 'Login failed'));
        }
      } on AuthException catch (e) {
        print('AuthException: [31m${e.message}[0m');
        emit(AuthError(message: e.message));
      } catch (e) {
        print('Login error: [31m$e[0m');
        emit(AuthError(message: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await Supabase.instance.client.auth.signOut();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}

