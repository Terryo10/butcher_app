import 'package:butcher_app/repositories/products_repository/products_provider.dart';

import '../../models/categories/categories_response_model.dart';

class ProductsRepository {
  final ProductsProvider provider;

  ProductsRepository({required this.provider});

  Future<CategoriesResponseModel> getCategories() async {
    return CategoriesResponseModel.fromJson(await provider.getCategories());
  }
}
