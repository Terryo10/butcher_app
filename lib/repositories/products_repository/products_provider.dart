import 'dart:convert';
import 'dart:io';
import 'package:butcher_app/static/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductsProvider {
  final FlutterSecureStorage storage;

  ProductsProvider({required this.storage});

  Future getCategories() async {
    try {
      String url = AppUrls.categories;

      var headers = <String, String>{
        "content-type": "application/json",
        'Accept': 'application/json',
      };
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode((response.body));
      } else {
        throw Exception("Oops! Something went wrong..");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }

  Future searchProducts({
    required String name,
    String? order,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      String url = AppUrls.searchProducts(name);

      // Define the request headers
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      // Build the request body
      var body = {
        "name": name,
        if (order != null) "order": order,
        if (category != null) "category": category,
        if (minPrice != null) "min_price": minPrice,
        if (maxPrice != null) "max_price": maxPrice,
      };

      // Make the POST request
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body), // Convert the body to JSON
      );

      // Handle the response
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Oops! Something went wrong...");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }
}
