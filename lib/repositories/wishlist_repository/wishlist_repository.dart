// lib/repositories/wishlist_repository/wishlist_repository.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/categories/product.dart';
import '../../static/app_urls.dart';

class WishlistRepository {
  final FlutterSecureStorage secureStorage;

  WishlistRepository({required this.secureStorage});

  Future<List<Product>> getWishlist() async {
    try {
      String url = AppUrls.wishlist;
      String? token = await secureStorage.read(key: 'token');

      var headers = <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> productsJson = responseData['data'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        }
      }

      return [];
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }

  Future<bool> addToWishlist(int productId) async {
    try {
      String url = AppUrls.wishlist;
      String? token = await secureStorage.read(key: 'token');

      var headers = <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      var body = jsonEncode({
        "product_id": productId,
      });

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['success'] == true;
      }

      return false;
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }

  Future<bool> removeFromWishlist(int productId) async {
    try {
      String url = AppUrls.wishlistRemove(productId);
      String? token = await secureStorage.read(key: 'token');

      var headers = <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['success'] == true;
      }

      return false;
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }

  Future<bool> isInWishlist(int productId) async {
    try {
      String url = AppUrls.wishlistCheck(productId);
      String? token = await secureStorage.read(key: 'token');

      var headers = <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['success'] == true &&
            responseData['in_wishlist'] == true;
      }

      return false;
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }
}
