import 'package:bookia/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserEntity user;
  final String message;

  LoginSuccessState({required this.user, required this.message});
}

class LoginErrorState extends AuthState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final UserEntity user;
  final String message;

  RegisterSuccessState({required this.user, required this.message});
}

class RegisterErrorState extends AuthState {
  final String errorMessage;

  RegisterErrorState(this.errorMessage);
}
