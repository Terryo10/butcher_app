import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/order_model.dart';
import '../../static/app_urls.dart';

class OrderRepository {
  final FlutterSecureStorage secureStorage;
  final http.Client httpClient;
  
  OrderRepository({
    FlutterSecureStorage? secureStorage,
    http.Client? httpClient,
  }) : 
    secureStorage = secureStorage ?? const FlutterSecureStorage(),
    httpClient = httpClient ?? http.Client();
  
  /// Get all orders with optional status filter
  Future<List<Order>> getOrders({String? status}) async {
    try {
      // Create URL with optional status parameter
      var uri = Uri.parse(AppUrls.orders);
      if (status != null && status.isNotEmpty) {
        uri = uri.replace(queryParameters: {'status': status});
      }
      
      final response = await httpClient.get(
        uri,
        headers: await _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Handle pagination structure if present
        final orders = data['orders']['data'] != null 
            ? data['orders']['data'] as List 
            : data['orders'] as List;
            
        return orders.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
  
  /// Get a specific order by ID
  Future<Order> getOrder(int orderId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('${AppUrls.orderDetails}/$orderId'),
        headers: await _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data['order']);
      } else {
        throw Exception('Failed to load order details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load order details: $e');
    }
  }
  
  /// Cancel an order
  Future<Order> cancelOrder(int orderId) async {
    try {
      final response = await httpClient.post(
        Uri.parse('${AppUrls.cancelOrder}/$orderId/cancel'),
        headers: await _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data['order']);
      } else {
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? 'Failed to cancel order';
        } catch (_) {
          errorMessage = 'Failed to cancel order: ${response.statusCode}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }
  
  /// Get order tracking information
  Future<OrderTracking> getOrderTracking(int orderId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('${AppUrls.orderTracking}/$orderId/tracking'),
        headers: await _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return OrderTracking.fromJson(data['tracking']);
      } else {
        throw Exception('Failed to load tracking information: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load tracking information: $e');
    }
  }
  

  Future<Map<String, String>> _getHeaders() async {
    final token = await secureStorage.read(key: 'token') ?? '';

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}