import 'package:bookia/features/auth/data/models/user_model.dart';
import 'package:bookia/features/auth/domain/entities/user_entity.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const String _baseUrl = "https://codingarabic.online/api/";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'login',
        data: LoginRequestModel(email: email, password: password).toJson(),
      );

      final data = response.data['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception(
          response.data['message']?.toString() ?? 'Something went wrong',
        );
      }

      final authResponse = AuthResponseModel.fromJson(data);
      await _saveToken(authResponse.token);
      return authResponse.user;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        'register',
        data: RegisterRequestModel(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ).toJson(),
      );

      final data = response.data['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception(
          response.data['message']?.toString() ?? 'Something went wrong',
        );
      }

      final authResponse = AuthResponseModel.fromJson(data);
      await _saveToken(authResponse.token);
      return authResponse.user;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Never _handleDioError(DioException e) {
    if (e.response != null) {
      final errors = e.response?.data?['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final firstField = errors.values.first;
        final firstMsg = firstField is List && firstField.isNotEmpty
            ? firstField.first.toString()
            : firstField.toString();
        throw Exception(firstMsg);
      }
      throw Exception(
        e.response?.data?['message']?.toString() ?? 'Something went wrong',
      );
    } else {
      throw Exception('Connection Error');
    }
  }
}
