import 'package:butcher_app/repositories/products_repository/products_provider.dart';

import '../../models/categories/categories_response_model.dart';
import '../../models/product_search/product_search_model.dart';

class ProductsRepository {
  final ProductsProvider provider;

  ProductsRepository({required this.provider});

  Future<CategoriesResponseModel> getCategories() async {
    return CategoriesResponseModel.fromJson(await provider.getCategories());
  }

  Future<SearchProductsResponse> searchProducts({
    required String name,
    String? order,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    final searchProductsResponse = searchProductsResponseFromMap(
        await provider.searchProducts(
            name: name,
            order: order,
            category: category,
            maxPrice: maxPrice,
            minPrice: minPrice));
    return searchProductsResponse;
  }
}
