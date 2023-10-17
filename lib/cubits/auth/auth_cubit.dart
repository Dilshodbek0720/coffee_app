import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/form/form_status.dart';
import '../../data/models/universal_data.dart';
import '../../data/repositories/auth_repository.dart';
import '../../utils/ui_utils/loading_dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState());

  final AuthRepository authRepository;

  void updatePhone(String phoneNumber) {
    debugPrint("AUTH PHONE: $phoneNumber");
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  Future<void> logOutUser() async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await authRepository.logOutUser();
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.unauthenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
  }

  Future<void> signUp(context) async {
    emit(state.copyWith(status: FormStatus.loading));
    showLoading(context: context);
    UniversalData data = await authRepository.signUpUser(
      email: "${state.phoneNumber}@gmail.com",
      password: "123456"
    );
    hideLoading(context: context);
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }

  Future<void> logIn(context) async {
    emit(state.copyWith(status: FormStatus.loading));
    showLoading(context: context);
    UniversalData data = await authRepository.loginUser(
      email: "${state.phoneNumber}@gmail.com",
      password: "1234567"
    );
    hideLoading(context: context);
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }

  String canAuthenticate() {
    if (state.phoneNumber.length < 9) {
      return "Enter valid phone number";
    }
    return "";
  }
}