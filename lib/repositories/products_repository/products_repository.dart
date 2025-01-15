import 'package:butcher_app/repositories/products_repository/products_provider.dart';

import '../../models/categories/categories_response_model_test.dart';

class ProductsRepository {
  final ProductsProvider provider;

  ProductsRepository({required this.provider});

  Future<CategoriesResponse> getCategories() async {
    return categoriesResponseFromMap(await provider.getCategories());
  }
}
