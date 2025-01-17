part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final LoginResponseModel loginResponseModel;

  const AuthAuthenticatedState(this.loginResponseModel);
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);
}

class AuthRegistrationSuccessState extends AuthState {
  final bool requiresVerification;
  final String? phone;

  const AuthRegistrationSuccessState({
    required this.requiresVerification,
    this.phone,
  });
}

class AuthVerificationSuccessState extends AuthState {}

