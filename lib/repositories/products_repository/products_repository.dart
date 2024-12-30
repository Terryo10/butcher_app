import 'package:butcher_app/repositories/products_repository/products_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductsRepository {
  final FlutterSecureStorage storage;
  final ProductsProvider provider;

  ProductsRepository({
    required this.storage,
    required this.provider
  });

  Future getCategories()async {

  }
}
