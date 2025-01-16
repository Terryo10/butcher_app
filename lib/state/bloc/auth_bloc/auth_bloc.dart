import 'package:bloc/bloc.dart';
import 'package:butcher_app/repositories/auth_repository/auth_repository.dart';
import 'package:butcher_app/state/bloc/cache_bloc/cache_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final CacheBloc cacheBloc;

  AuthBloc({
    required this.authRepository,
    required this.cacheBloc,
  }) : super(AuthInitial()) {
    on<AuthenticateUser>((event, emit) async {});

    on<LogOut>((event, emit) async {
      await authRepository.logOut();
      cacheBloc.add(AppStarted());
    });
  }
}
