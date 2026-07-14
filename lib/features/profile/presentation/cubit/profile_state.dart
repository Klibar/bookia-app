import 'package:bookia/features/auth/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileUpdatingState extends ProfileState {}

class ProfileUpdatedState extends ProfileState {
  final UserEntity user;
  ProfileUpdatedState(this.user);
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
}

class PasswordUpdatingState extends ProfileState {}

class PasswordUpdatedState extends ProfileState {}

class PasswordErrorState extends ProfileState {
  final String message;
  PasswordErrorState(this.message);
}
