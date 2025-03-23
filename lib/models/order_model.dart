import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final String orderNumber;
  final String status;
  final String paymentStatus;
  final String? paymentType; // Made nullable
  final double subtotal;
  final double? shippingAmount; // Made nullable
  final double? taxAmount; // Made nullable
  final double? discountAmount; // Made nullable
  final String? couponCode;
  final double total;
  final String? notes;
  final String? trackingNumber;
  final DateTime createdAt;
  final DateTime? updatedAt; // Made nullable
  final List<OrderItem> items;
  final Address? address;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentStatus,
    this.paymentType, // Changed to optional
    required this.subtotal,
    this.shippingAmount, // Changed to optional
    this.taxAmount, // Changed to optional
    this.discountAmount, // Changed to optional
    this.couponCode,
    required this.total,
    this.notes,
    this.trackingNumber,
    required this.createdAt,
    this.updatedAt, // Changed to optional
    required this.items,
    this.address,
  });

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        status,
        paymentStatus,
        paymentType,
        subtotal,
        shippingAmount,
        taxAmount,
        discountAmount,
        couponCode,
        total,
        notes,
        trackingNumber,
        createdAt,
        updatedAt,
        items,
        address,
      ];

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      paymentType: json['payment_type'],
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingAmount: json['shipping_amount'] != null
          ? (json['shipping_amount'] as num).toDouble()
          : null,
      taxAmount: json['tax_amount'] != null
          ? (json['tax_amount'] as num).toDouble()
          : null,
      discountAmount: json['discount_amount'] != null
          ? (json['discount_amount'] as num).toDouble()
          : null,
      couponCode: json['coupon_code'],
      total: (json['total'] as num).toDouble(),
      notes: json['notes'],
      trackingNumber: json['tracking_number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      items: json['items'] != null
          ? List<OrderItem>.from(
              json['items'].map((x) => OrderItem.fromJson(x)))
          : [],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }
}

class OrderItem extends Equatable {
  final int id;
  final int orderId;
  final int? productId;
  final String name;
  final double price;
  final String quantity;
  final String? unit;
  final String? pricingType; // Made nullable
  final double totalPrice;

  const OrderItem({
    required this.id,
    required this.orderId,
    this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.unit,
    this.pricingType, // Changed to optional
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        name,
        price,
        quantity,
        unit,
        pricingType,
        totalPrice,
      ];

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      unit: json['unit'],
      pricingType: json['pricing_type'],
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }
}

class Address extends Equatable {
  final int id;
  final int userId;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state; // Made nullable
  final String postalCode;
  final String country;
  final bool isDefault;

  const Address({
    required this.id,
    required this.userId,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    this.state, // Changed to optional
    required this.postalCode,
    required this.country,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        addressLine1,
        addressLine2,
        city,
        state,
        postalCode,
        country,
        isDefault,
      ];

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      userId: json['user_id'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      isDefault: json['is_default'] ?? false,
    );
  }
}

class OrderResult extends Equatable {
  final Order order;
  final Map<String, dynamic>? paymentResult; // Made nullable

  const OrderResult({
    required this.order,
    this.paymentResult, // Changed to optional
  });

  @override
  List<Object?> get props => [order, paymentResult];

  factory OrderResult.fromJson(Map<String, dynamic> json) {
    return OrderResult(
      order: Order.fromJson(json['order']),
      paymentResult: json['payment_result'],
    );
  }
}

class OrderTracking extends Equatable {
  final String orderNumber;
  final String status;
  final String? trackingNumber;
  final String? estimatedDelivery;
  final List<TrackingHistory>? trackingHistory; // Made nullable

  const OrderTracking({
    required this.orderNumber,
    required this.status,
    this.trackingNumber,
    this.estimatedDelivery,
    this.trackingHistory, // Changed to optional
  });

  @override
  List<Object?> get props => [
        orderNumber,
        status,
        trackingNumber,
        estimatedDelivery,
        trackingHistory,
      ];

  factory OrderTracking.fromJson(Map<String, dynamic> json) {
    return OrderTracking(
      orderNumber: json['order_number'],
      status: json['status'],
      trackingNumber: json['tracking_number'],
      estimatedDelivery: json['estimated_delivery'],
      trackingHistory: json['tracking_history'] != null
          ? List<TrackingHistory>.from(
              json['tracking_history'].map((x) => TrackingHistory.fromJson(x)))
          : null,
    );
  }
}

class TrackingHistory extends Equatable {
  final String date;
  final String status;
  final String? location; // Made nullable

  const TrackingHistory({
    required this.date,
    required this.status,
    this.location, // Changed to optional
  });

  @override
  List<Object?> get props => [date, status, location];

  factory TrackingHistory.fromJson(Map<String, dynamic> json) {
    return TrackingHistory(
      date: json['date'],
      status: json['status'],
      location: json['location'],
    );
  }
}
