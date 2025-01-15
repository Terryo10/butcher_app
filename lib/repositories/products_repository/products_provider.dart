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
        return response.body;
      } else {
        throw Exception("Oops! Something went wrong..");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw Exception("Oops! Something went wrong...");
    }
  }
}
