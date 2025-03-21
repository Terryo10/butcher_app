// cart_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/cart/cart_item.dart';
import '../../models/cart/cart_model.dart';
import '../../static/app_urls.dart';

class CartRepository {
  final FlutterSecureStorage secureStorage;

  CartRepository({
    required this.secureStorage,
  });

  // Get cart from API
  Future<Cart> getCart() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrls.cart),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load cart: ${response.statusCode}');
      }
    } catch (e) {
      // Try to get local cart if API call fails
      final localCart = await getLocalCart();
      if (localCart != null) {
        return localCart;
      }
      throw Exception('Failed to load cart: $e');
    }
  }

  // Add item to cart
  Future<Cart> addToCart(
    int productId,
    dynamic quantity, {
    String? name,
    double? price,
    String? image,
    String? unit,
    String? pricingType,
    double? unitPrice,
  }) async {
    try {
      // Use Map<String, dynamic> to allow different types in the payload
      final Map<String, dynamic> payload = {
        'product_id': productId,
        'quantity': quantity.toString(), // Convert quantity to string for API
      };

      // Add optional fields if provided (useful for offline-first approach)
      if (name != null) payload['name'] = name;
      if (price != null) payload['price'] = price;
      if (image != null) payload['image'] = image;
      if (unit != null) payload['unit'] = unit;
      if (pricingType != null) payload['pricing_type'] = pricingType;
      if (unitPrice != null) payload['unit_price'] = unitPrice;

      final response = await http.post(
        Uri.parse(AppUrls.cartAdd),
        headers: await _getHeaders(),
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final cart = Cart.fromJson(jsonDecode(response.body));
        await saveCartLocally(cart);
        return cart;
      } else {
        throw Exception('Failed to add item to cart: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to local cart update if API fails
      final currentCart = await getLocalCart() ?? const Cart();

      // Find if item already exists
      final existingItemIndex =
          currentCart.items.indexWhere((item) => item.productId == productId);

      // Create a new list with the correct type
      List<CartItem> updatedItems = List<CartItem>.from(currentCart.items);

      if (existingItemIndex >= 0) {
        // Update existing item
        final existingItem = currentCart.items[existingItemIndex];
        
        dynamic newQuantity;
        if (pricingType == 'weight' || existingItem.isWeightBased) {
          // For weight-based products, add as double
          newQuantity = existingItem.quantityAsDouble + 
              (quantity is double ? quantity : double.parse(quantity.toString()));
        } else {
          // For fixed-price products, add as int
          newQuantity = (existingItem.quantity as int) + 
              (quantity is int ? quantity : int.parse(quantity.toString()));
        }
        
        final updatedItem = existingItem.copyWith(
          quantity: newQuantity,
          // Recalculate totalPrice
          totalPrice: existingItem.price * 
              (newQuantity is double ? newQuantity : newQuantity.toDouble()),
        );

        updatedItems[existingItemIndex] = updatedItem;
      } else if (name != null && price != null && image != null) {
        // Only add new item if we have the required data
        // Calculate total price based on pricing type
        final double totalPrice = price * 
            (quantity is double ? quantity : double.parse(quantity.toString()));
        
        updatedItems.add(CartItem(
          id: DateTime.now().millisecondsSinceEpoch,
          name: name,
          price: price,
          quantity: quantity,
          image: image,
          productId: productId,
          unit: unit,
          pricingType: pricingType ?? 'fixed',
          unitPrice: price,
          totalPrice: totalPrice,
        ));
      } else {
        throw Exception(
            'Cannot add item to cart offline without product details');
      }

      // Calculate new total amount
      final totalAmount = updatedItems.fold(
        0.0,
        (sum, item) => sum + item.calculatedTotalPrice,
      );

      // Create updated cart
      final updatedCart = currentCart.copyWith(
        items: updatedItems,
        totalAmount: totalAmount,
        itemCount: updatedItems.length,
      );

      await saveCartLocally(updatedCart);

      return updatedCart;
    }
  }

  // Update item quantity
  Future<Cart> updateCartItem(int cartItemId, dynamic quantity) async {
    try {
      final response = await http.put(
        Uri.parse('${AppUrls.cartUpdate}/$cartItemId'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'quantity': quantity.toString(), // Convert quantity to string for API
        }),
      );

      if (response.statusCode == 200) {
        final cart = Cart.fromJson(jsonDecode(response.body));
        await saveCartLocally(cart);
        return cart;
      } else {
        throw Exception('Failed to update cart item: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to local cart update if API fails
      final currentCart = await getLocalCart() ?? const Cart();

      if ((quantity is int && quantity <= 0) || 
          (quantity is double && quantity <= 0)) {
        return removeFromCart(cartItemId);
      }

      // Find the item to update
      final itemIndex =
          currentCart.items.indexWhere((item) => item.id == cartItemId);

      if (itemIndex < 0) {
        throw Exception('Item not found in cart');
      }

      // Create updated items list with correct type
      final updatedItems = List<CartItem>.from(currentCart.items);
      final item = updatedItems[itemIndex];
      
      // Calculate new total price
      final double totalPrice = item.price * 
          (quantity is double ? quantity : double.parse(quantity.toString()));
      
      final updatedItem = item.copyWith(
        quantity: quantity,
        totalPrice: totalPrice,
      );
      
      updatedItems[itemIndex] = updatedItem;

      // Calculate new total amount
      final totalAmount = updatedItems.fold(
        0.0,
        (sum, item) => sum + item.calculatedTotalPrice,
      );

      // Create updated cart
      final updatedCart = currentCart.copyWith(
        items: updatedItems,
        totalAmount: totalAmount,
        itemCount: updatedItems.length,
      );

      await saveCartLocally(updatedCart);

      return updatedCart;
    }
  }

  // Remove item from cart
  Future<Cart> removeFromCart(int cartItemId) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppUrls.cartRemove}/$cartItemId'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final cart = Cart.fromJson(jsonDecode(response.body));
        await saveCartLocally(cart);
        return cart;
      } else {
        throw Exception(
            'Failed to remove item from cart: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to local cart update if API fails
      final currentCart = await getLocalCart() ?? const Cart();

      // Remove the item and ensure correct type
      final updatedItems = currentCart.items
          .where((item) => item.id != cartItemId)
          .toList();

      // Calculate new total amount
      final totalAmount = updatedItems.fold(
        0.0,
        (sum, item) => sum + item.calculatedTotalPrice,
      );

      // Create updated cart
      final updatedCart = currentCart.copyWith(
        items: updatedItems,
        totalAmount: totalAmount,
        itemCount: updatedItems.length,
      );

      await saveCartLocally(updatedCart);

      return updatedCart;
    }
  }

  // Apply coupon code
  Future<Cart> applyCoupon(String couponCode) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrls.cartCouponApply),
        headers: await _getHeaders(),
        body: jsonEncode({
          'coupon_code': couponCode,
        }),
      );

      if (response.statusCode == 200) {
        final cart = Cart.fromJson(jsonDecode(response.body));
        await saveCartLocally(cart);
        return cart;
      } else {
        throw Exception('Failed to apply coupon: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to apply coupon. Please try again when online.');
    }
  }

  // Remove coupon code
  Future<Cart> removeCoupon() async {
    try {
      final response = await http.delete(
        Uri.parse(AppUrls.cartCouponRemove),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final cart = Cart.fromJson(jsonDecode(response.body));
        await saveCartLocally(cart);
        return cart;
      } else {
        throw Exception('Failed to remove coupon: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to local coupon removal
      final currentCart = await getLocalCart() ?? const Cart();

      // Remove coupon from cart
      final updatedCart = currentCart.copyWith(
        couponCode: null,
        discountAmount: null,
      );

      await saveCartLocally(updatedCart);

      return updatedCart;
    }
  }

  // Clear cart
  Future<Cart> clearCart() async {
    try {
      final response = await http.delete(
        Uri.parse(AppUrls.cartClear),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        await secureStorage.delete(key: 'local_cart');
        return const Cart();
      } else {
        throw Exception('Failed to clear cart: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to local cart clear
      await secureStorage.delete(key: 'local_cart');
      return const Cart();
    }
  }

  // Get headers with auth token
  Future<Map<String, String>> _getHeaders() async {
    // Get token from secure storage
    final token = await secureStorage.read(key: 'auth_token') ?? '';

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Local cart storage methods
  Future<void> saveCartLocally(Cart cart) async {
    await secureStorage.write(
      key: 'local_cart',
      value: jsonEncode(cart.toJson()),
    );
  }

  Future<Cart?> getLocalCart() async {
    final cartJson = await secureStorage.read(key: 'local_cart');
    if (cartJson != null) {
      try {
        return Cart.fromJson(jsonDecode(cartJson));
      } catch (e) {
        // If parsing fails, return null
        return null;
      }
    }
    return null;
  }

  // Sync local cart with server (useful after login or when coming back online)
  Future<Cart> syncCart() async {
    final localCart = await getLocalCart();

    // If no local cart, just get the server cart
    if (localCart == null || localCart.items.isEmpty) {
      return getCart();
    }

    try {
      // Send local cart to server for syncing
      final response = await http.post(
        Uri.parse(AppUrls.cartSync),
        headers: await _getHeaders(),
        body: jsonEncode(localCart.toJson()),
      );

      if (response.statusCode == 200) {
        final serverCart = Cart.fromJson(jsonDecode(response.body));
        await saveCartLocally(serverCart);
        return serverCart;
      } else {
        // If sync fails, keep the local cart
        return localCart;
      }
    } catch (e) {
      // If sync fails, keep the local cart
      return localCart;
    }
  }
}