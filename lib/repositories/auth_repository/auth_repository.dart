import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  FlutterSecureStorage storage;

  AuthRepository({required this.storage});

  Future<void> logOut() async {
    storage.deleteAll();
  }
  
}