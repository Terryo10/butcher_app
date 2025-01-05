part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthFirstLaunch extends AuthState {
  final dynamic isFirstLaunch;

  const AuthFirstLaunch({required this.isFirstLaunch});
}
