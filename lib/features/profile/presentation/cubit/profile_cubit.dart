import 'package:bookia/features/auth/domain/entities/user_entity.dart';
import 'package:bookia/features/profile/domain/repositories/profile_repository.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitialState());

  Future<void> updateProfile({
    required UserEntity current,
    required String name,
    String? phone,
    String? city,
    String? address,
  }) async {
    emit(ProfileUpdatingState());
    try {
      final updated = await repository.updateProfile(
        current: current,
        name: name,
        phone: phone,
        city: city,
        address: address,
      );
      emit(ProfileUpdatedState(updated));
    } catch (e) {
      emit(ProfileErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(PasswordUpdatingState());
    try {
      await repository.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(PasswordUpdatedState());
    } catch (e) {
      emit(PasswordErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
