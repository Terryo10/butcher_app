import 'package:bloc/bloc.dart';
import 'package:butcher_app/models/auth/login_response_model.dart';
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
    on<LoginWithCredentials>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final response = await authRepository.login(
          identifier: event.identifier,
          password: event.password,
        );
        await authRepository.saveToken('${response.token}');
        cacheBloc.add(AppStarted());
        emit(AuthAuthenticatedState(response));
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    // on<RegisterUser>((event, emit) async {
    //   try {
    //     emit(AuthLoadingState());
    //     final response = await authRepository.register(
    //       name: event.name,
    //       email: event.email,
    //       phone: event.phone,
    //       password: event.password,
    //       passwordConfirmation: event.passwordConfirmation,
    //     );
    //     emit(AuthRegistrationSuccessState(
    //       requiresVerification: event.phone != null,
    //       phone: event.phone,
    //     ));
    //   } catch (e) {
    //     emit(AuthErrorState(e.toString()));
    //   }
    // });

    // on<VerifyOTP>((event, emit) async {
    //   try {
    //     emit(AuthLoadingState());
    //     await authRepository.verifyOTP(
    //       phone: event.phone,
    //       otp: event.otp,
    //     );
    //     emit(AuthVerificationSuccessState());
    //   } catch (e) {
    //     emit(AuthErrorState(e.toString()));
    //   }
    // });

    on<LoginWithGoogle>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final response = await authRepository.loginWithGoogle();
        await authRepository.saveToken('${response.token}');
       
        Future.delayed(Duration.zero,(){
           cacheBloc.add(AppStarted());
        });
        emit(AuthAuthenticatedState(response));
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    // on<LoginWithApple>((event, emit) async {
    //   try {
    //     emit(AuthLoadingState());
    //     final response = await authRepository.loginWithApple();
    //     emit(AuthAuthenticatedState(response['user']));
    //   } catch (e) {
    //     emit(AuthErrorState(e.toString()));
    //   }
    // });

    on<LogOut>((event, emit) async {
      await authRepository.logOut();
      cacheBloc.add(AppStarted());
      emit(AuthInitial());
    });
  }
}
