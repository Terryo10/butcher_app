import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/checkout/checkout_model.dart';
import '../../models/cart/cart_model.dart';
import '../../static/app_urls.dart';

class CheckoutRepository {
  final FlutterSecureStorage secureStorage;

  CheckoutRepository({
    required this.secureStorage,
  });

  // Get user addresses
  Future<List<Address>> getAddresses() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrls.addresses),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['addresses'] as List)
            .map((address) => Address.fromJson(address))
            .toList();
      } else {
        throw Exception('Failed to load addresses: ${response.statusCode}');
      }
    } catch (e) {
      // If offline or error, return empty list
      return [];
    }
  }

  // Add a new address
  Future<Address> addAddress(Address address) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrls.addAddress),
        headers: await _getHeaders(),
        body: jsonEncode(address.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Address.fromJson(data['address']);
      } else {
        throw Exception('Failed to add address: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  // Get saved payment methods
  Future<List<PaymentMethod>> getSavedPaymentMethods() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrls.paymentMethods),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['payment_methods'] as List)
            .map((method) => PaymentMethod.fromJson(method))
            .toList();
      } else {
        throw Exception(
            'Failed to load payment methods: ${response.statusCode}');
      }
    } catch (e) {
      // If offline or error, return empty list
      return [];
    }
  }

  // Place order
  Future<OrderResult> placeOrder({
    required Cart cart,
    required int addressId,
    required PaymentType paymentType,
    int? paymentMethodId,
    CardDetails? cardDetails,
    bool saveCard = false,
    String? notes,
  }) async {
    // Prepare the order data
    final Map<String, dynamic> orderData = {
      'address_id': addressId,
      'payment_type': paymentType.toString().split('.').last,
      'items': cart.items
          .map((item) => {
                'product_id': item.productId,
                'quantity': item.quantity.toString(),
                'pricing_type': item.pricingType,
                'unit': item.unit,
              })
          .toList(),
    };

    // Add optional note if provided
    if (notes != null && notes.isNotEmpty) {
      orderData['notes'] = notes;
    }

    // Add coupon code if available
    if (cart.couponCode != null && cart.couponCode!.isNotEmpty) {
      orderData['coupon_code'] = cart.couponCode;
    }

    // Add payment method ID if using a saved payment method
    if (paymentMethodId != null) {
      orderData['payment_method_id'] = paymentMethodId;
    }

    // Add card details if provided
    if (cardDetails != null) {
      orderData['card_details'] = cardDetails.toJson();
      orderData['save_card'] = saveCard;
    }

    try {
      final response = await http.post(
        Uri.parse(AppUrls.checkout),
        headers: await _getHeaders(),
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return OrderResult.fromJson(data['order']);
      } else {
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? 'Failed to place order';
        } catch (_) {
          errorMessage = 'Failed to place order: ${response.statusCode}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  // Get headers with auth token
  Future<Map<String, String>> _getHeaders() async {
    // Get token from secure storage
    final token = await secureStorage.read(key: 'token') ?? '';

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
