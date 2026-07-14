import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final user = await loginUseCase(email: email, password: password);
      emit(LoginSuccessState(user: user, message: 'Logged in Successfully'));
    } catch (e) {
      emit(LoginErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoadingState());
    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      emit(
        RegisterSuccessState(user: user, message: 'Registered Successfully'),
      );
    } catch (e) {
      emit(RegisterErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
