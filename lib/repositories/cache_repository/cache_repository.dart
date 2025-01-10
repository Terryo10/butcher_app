import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheRepository {
  final FlutterSecureStorage storage;

  CacheRepository({required this.storage});

  Future<bool> hasAuthenticationToken() async {
    return await storage.read(key: 'token') != null;
  }
}
