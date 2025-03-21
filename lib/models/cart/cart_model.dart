import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Cart extends Equatable {
  final List<CartItem> items;
  final double? totalAmount;
  final int itemCount;
  final double? discountAmount;
  final String? couponCode;

  const Cart({
    this.items = const [],
    this.totalAmount,
    this.itemCount = 0,
    this.discountAmount,
    this.couponCode,
  });

  // Calculate the total amount if not provided
  double get calculatedTotalAmount {
    return totalAmount ?? items.fold(
      0.0, 
      (sum, item) => sum + item.calculatedTotalPrice,
    );
  }

  // Calculate the final amount after discount
  double get finalAmount {
    final total = calculatedTotalAmount;
    if (discountAmount != null && discountAmount! > 0) {
      return total - discountAmount!;
    }
    return total;
  }

  // Count weight-based and fixed-price items
  int get weightBasedItemCount => items.where((item) => item.isWeightBased).length;
  int get fixedPriceItemCount => items.where((item) => !item.isWeightBased).length;

  Cart copyWith({
    List<CartItem>? items,
    double? totalAmount,
    int? itemCount,
    double? discountAmount,
    String? couponCode,
  }) {
    return Cart(
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      itemCount: itemCount ?? this.itemCount,
      discountAmount: discountAmount ?? this.discountAmount,
      couponCode: couponCode ?? this.couponCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total_amount': calculatedTotalAmount,
      'coupon_code': couponCode,
      'discount_amount': discountAmount,
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    final itemsList = (json['items'] as List)
        .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
        .toList();
    
    return Cart(
      items: itemsList,
      totalAmount: json['total_amount'] != null 
          ? double.parse(json['total_amount'].toString()) 
          : null,
      itemCount: itemsList.length,
      couponCode: json['coupon_code'] as String?,
      discountAmount: json['discount_amount'] != null
          ? double.parse(json['discount_amount'].toString())
          : null,
    );
  }

  @override
  List<Object?> get props => [
    items, 
    totalAmount, 
    itemCount, 
    couponCode, 
    discountAmount
  ];
}