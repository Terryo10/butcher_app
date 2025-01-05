import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FlutterSecureStorage storage;

  AuthBloc({required this.storage}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FirstAppLaunchEvent>((event, emit) async {
      dynamic isFirstTime = await storage.read(key: 'isOpenedApp') ?? 'true';
      if (isFirstTime == 'true') {
        storage.write(key: 'isOpenedApp', value: true.toString());
        emit(const AuthFirstLaunch(isFirstLaunch: true));
      } else {
        storage.write(key: 'isOpenedApp', value: false.toString());
        emit(const AuthFirstLaunch(isFirstLaunch: false));
      }
    });
  }
}
