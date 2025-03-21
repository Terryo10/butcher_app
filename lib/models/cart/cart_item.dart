import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final String name;
  final double price;
  final dynamic quantity; // Can be int or double based on product type
  final String image;
  final int productId;
  final String? unit; // For displaying unit (kg, lb, piece, etc.)
  final String? pricingType; // 'fixed' or 'weight'
  final double? unitPrice; // Price per unit
  final double? totalPrice; // Total price for this item

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.productId,
    this.unit,
    this.pricingType = 'fixed',
    this.unitPrice,
    this.totalPrice,
  });

  // Check if item is weight-based
  bool get isWeightBased => pricingType == 'weight';

  // Get quantity as double (for calculations)
  double get quantityAsDouble {
    if (quantity is int) {
      return quantity.toDouble();
    }
    return (quantity is double) ? quantity : double.parse(quantity.toString());
  }

  // Get quantity as formatted string
  String get formattedQuantity {
    if (isWeightBased) {
      return '$quantityAsDouble ${unit ?? ''}';
    }
    // For fixed price, always show as integer
    return '${quantity.round()}';
  }

  // Calculate total price if not provided
  double get calculatedTotalPrice {
    return totalPrice ?? (price * quantityAsDouble);
  }

  // Display name including unit information
  String get displayName {
    if (unit != null && unit!.isNotEmpty) {
      return '$name ($unit)';
    }
    return name;
  }

  // Display price with unit for weight-based products
  String get displayPrice {
    if (isWeightBased) {
      return '\$${price.toStringAsFixed(2)}/${unit ?? 'unit'}';
    }
    return '\$${price.toStringAsFixed(2)}';
  }

  CartItem copyWith({
    int? id,
    String? name,
    double? price,
    dynamic quantity,
    String? image,
    int? productId,
    String? unit,
    String? pricingType,
    double? unitPrice,
    double? totalPrice,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      productId: productId ?? this.productId,
      unit: unit ?? this.unit,
      pricingType: pricingType ?? this.pricingType,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'product_id': productId,
      'pricing_type': pricingType,
    };
    
    if (unit != null) data['unit'] = unit;
    if (unitPrice != null) data['unit_price'] = unitPrice;
    if (totalPrice != null) data['total_price'] = totalPrice;
    
    return data;
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    // Handle quantity properly based on pricing type
    final pricingType = json['pricing_type'] as String? ?? 'fixed';
    
    dynamic quantity;
    if (pricingType == 'weight') {
      // For weight-based products, parse as double
      quantity = double.parse(json['quantity'].toString());
    } else {
      // For fixed-price products, parse as int
      quantity = int.parse(json['quantity'].toString());
    }

    return CartItem(
      id: json['id'] as int,
      name: json['name'] as String,
      price: double.parse(json['price'].toString()),
      quantity: quantity,
      image: json['image'] as String,
      productId: json['product_id'] as int,
      unit: json['unit'] as String?,
      pricingType: pricingType,
      unitPrice: json['unit_price'] != null ? double.parse(json['unit_price'].toString()) : null,
      totalPrice: json['total_price'] != null ? double.parse(json['total_price'].toString()) : null,
    );
  }

  @override
  List<Object?> get props => [
    id, 
    productId, 
    quantity, 
    name, 
    price, 
    image, 
    unit, 
    pricingType,
    unitPrice,
    totalPrice,
  ];
}