part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateUser extends AuthEvent {}

class Registration extends AuthEvent {}

class ForgotPassword extends AuthEvent {}

class SubmitOTP extends AuthEvent {}

class AuthenticateFromCache extends AuthEvent{}
