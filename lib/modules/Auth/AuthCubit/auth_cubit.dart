import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/core/resources/string_manager.dart';
import 'package:egytraveler/shared/network/remote/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String name,
    required String password,
    required String email,
    required String passwordConfirm,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
      url: AppStrings.signup,
      data: {
        "email": email,
        "name": name,
        "password": password,
        "passwordConfirm": passwordConfirm,
      },
    ).then((value) {
      print(value.data);
      emit(RegisterSuccessState(value.data));
    }).catchError((onError) {
      if (onError is DioError) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(RegisterErrorState(onError.response!.data['message']));
      }
    });
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(SingInLoadingState());
    await DioHelper.postData(
      url: AppStrings.signin,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(SingInSuccessState(value.data));
    }).catchError((onError) {
      print(onError.toString());
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(SingInErrorState(onError.response!.data['message']));
      }
    });
  }

  Future<void> sendEmailForRestPass({
    required String email,
  }) async {
    emit(ResetPasswordLoading());
    await DioHelper.postData(
      url: AppStrings.forgotPassword,
      data: {
        'email': email,
      },
    ).then((value) {
      print(value.data);
      emit(ResetPasswordSuccess(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(ResetPasswordError(onError.response!.data['message']));
      }
    });
  }

  Future<void> verify({
    required String email,
    required String otpCode,
    required String password,
    required String passwordConfirm,
  }) async {
    emit(OtpLoading());
    print(email);
    print(otpCode);
    await DioHelper.putData(
      url: AppStrings.resetPassword,
      data: {
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'forgetCode': otpCode,
      },
    ).then((value) {
      print(otpCode);
      print(value.data);
      emit(OtpSuccess(value.data));
    }).catchError((onError) {
      if (onError is DioException) {
        debugPrint(onError.response!.data['message']);
        debugPrint(onError.message);
        emit(OtpError(onError.response!.data['message']));
      }
    });
  }

  IconData suffixIN = Icons.visibility_outlined;

  bool isPasswordShownIN = true;

  void changePasswordVisibilityIN() {
    debugPrint('changePasswordVisibility');
    isPasswordShownIN = !isPasswordShownIN;
    suffixIN = isPasswordShownIN
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStateIN());
  }

  IconData suffixUp = Icons.visibility_outlined;

  bool isPasswordShownUp = true;

  void changePasswordVisibilityUp() {
    debugPrint('changePasswordVisibility');
    isPasswordShownUp = !isPasswordShownUp;
    suffixUp = isPasswordShownUp
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStateUp());
  }

  IconData suffix1 = Icons.visibility_outlined;

  bool isPasswordShown1 = true;

  void changePasswordVisibility1() {
    debugPrint('changePasswordVisibility');
    isPasswordShown1 = !isPasswordShown1;
    suffix1 = isPasswordShown1
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState1());
  }

  IconData suffix2 = Icons.visibility_outlined;

  bool isPasswordShown2 = true;

  void changePasswordVisibility2() {
    debugPrint('changePasswordVisibility');
    isPasswordShown2 = !isPasswordShown2;
    suffix2 = isPasswordShown2
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState2());
  }
}
