import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:microdigital/auth/authservices.dart';

import '../../auth/Models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    emit(AuthLoading());

    await AuthService.loadTokens();
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (AuthService.isAuthenticated()) {
        final response = await UserRepository.getUserData();
        emit(AuthSuccess(response));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      // emit(AuthInitial());
    }
  }

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());

    try {
      final response = await AuthService.loGin(phone, password);

      emit(AuthSuccess(response));
    } catch (e) {
      print(e);
      emit(
        AuthError(errorMsg: 'Something went wrong ...'),
      );
    }
  }

  Future<void> signUp(
    dynamic phone,
    dynamic nni,
    String password,
    String password2,
    String nom,
    String prenom,
    // String post,
    // String imagePath,
  ) async {
    emit(AuthLoading());
    try {
      final response = await AuthService.signUp(
        nni,
        nom,
        phone,
        prenom,
        password,
        password2,
      );

      if (response) {
        
        print(response);
        emit(
          SignUpSuccess(success: 'Account created successfully...'),
        );
      }
    } catch (e) {
      print(e);
      // emit(AuthError(errorMsg: e.toString()));
    }
  }

  void logOut() {
    AuthService.clearTokens();
    emit(AuthInitial());
  }

  void signIn() {
    emit(AuthInitial());
  }
}
