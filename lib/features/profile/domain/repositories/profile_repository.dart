import 'package:bookia/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> updateProfile({
    required UserEntity current,
    required String name,
    String? phone,
    String? city,
    String? address,
  });

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  });
}
