part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  dynamic successModel ;
  RegisterSuccessState(this.successModel) ;
}

class RegisterErrorState extends AuthState {
  String? errorModel ;
  RegisterErrorState(this.errorModel) ;
}

class SingInLoadingState extends AuthState {}

class SingInSuccessState extends AuthState {
  dynamic successModel ;
  SingInSuccessState(this.successModel) ;
}

class SingInErrorState extends AuthState {
  final String? errorModel ;
  SingInErrorState(this.errorModel) ;
}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {
  dynamic successModel ;
  ResetPasswordSuccess(this.successModel) ;
}

class ResetPasswordError extends AuthState {

  dynamic errorModel ;
  ResetPasswordError(this.errorModel) ;
}

class OtpLoading extends AuthState {}

class OtpSuccess extends AuthState {
  dynamic successModel ;
  OtpSuccess(this.successModel) ;
}

class OtpError extends AuthState {
  dynamic errorModel ;
  OtpError(this.errorModel) ;
}

class ChangePasswordVisibilityState extends AuthState {}
