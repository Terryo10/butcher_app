import 'package:butcher_app/models/auth/login_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_provider.dart';

class AuthRepository {
  final AuthProvider authProvider;
  FlutterSecureStorage storage;

  AuthRepository({required this.storage, required this.authProvider});

  Future<void> logOut() async {
    await storage.deleteAll();
  }

  Future<LoginResponseModel> login({
    required String identifier,
    required String password,
  }) async {
    return LoginResponseModel.fromJson(
      await authProvider.login(
        identifier: identifier,
        password: password,
      ),
    );
  }

  Future<LoginResponseModel> loginWithGoogle() async {
    return LoginResponseModel.fromJson(
      await authProvider.loginWithGoogle(),
    );
  }
}
