import 'package:bookia/features/auth/domain/entities/user_entity.dart';
import 'package:bookia/features/profile/domain/repositories/profile_repository.dart';

/// Dummy implementation. TODO: replace with PUT /profile and
/// POST /change-password calls (same Dio + token pattern as
/// AuthRepositoryImpl) once the real endpoints are ready.
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserEntity> updateProfile({
    required UserEntity current,
    required String name,
    String? phone,
    String? city,
    String? address,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return UserEntity(
      id: current.id,
      name: name,
      email: current.email,
      address: address ?? current.address,
      city: city ?? current.city,
      phone: phone ?? current.phone,
      emailVerified: current.emailVerified,
      image: current.image,
    );
  }

  @override
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (currentPassword.isEmpty) {
      throw Exception('Current password is required');
    }
    // Dummy success — no real validation until the API is connected.
  }
}
