// address_model.dart
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int id;
  final String label;
  final String fullName;
  final String phoneNumber;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final bool isDefault;
  
  const Address({
    required this.id,
    required this.label,
    required this.fullName,
    required this.phoneNumber,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });
  
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      label: json['label'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      isDefault: json['is_default'] ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
      'is_default': isDefault,
    };
  }
  
  String get formattedAddress {
    final parts = [
      addressLine1,
      if (addressLine2 != null && addressLine2!.isNotEmpty) addressLine2,
      "$city, $state $postalCode",
      country,
    ];
    
    return parts.join(', ');
  }
  
  @override
  List<Object?> get props => [
    id, 
    label, 
    fullName, 
    phoneNumber, 
    addressLine1, 
    addressLine2, 
    city, 
    state, 
    postalCode, 
    country,
    isDefault,
  ];
}


enum PaymentType {
  card,
  paypal,
  cashOnDelivery
}

class PaymentMethod extends Equatable {
  final int id;
  final String type; // 'card', 'paypal', etc.
  final String name; // 'Visa ending in 4242', 'PayPal - johndoe@example.com'
  final bool isDefault;
  final Map<String, dynamic>? details; // Card details or other type-specific info
  
  const PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    this.isDefault = false,
    this.details,
  });
  
  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      isDefault: json['is_default'] ?? false,
      details: json['details'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'is_default': isDefault,
      'details': details,
    };
  }
  
  @override
  List<Object?> get props => [id, type, name, isDefault, details];
}

class CardDetails extends Equatable {
  final String cardName;
  final String cardNumber;
  final String expirationDate;
  final String cvv;
  
  const CardDetails({
    required this.cardName,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'card_name': cardName,
      'card_number': cardNumber,
      'expiration_date': expirationDate,
      'cvv': cvv,
    };
  }
  
  @override
  List<Object> get props => [cardName, cardNumber, expirationDate, cvv];
}


class OrderResult extends Equatable {
  final int id;
  final String orderNumber;
  final double total;
  final String status;
  final String paymentStatus;
  final String? trackingNumber;
  final DateTime createdAt;
  
  const OrderResult({
    required this.id,
    required this.orderNumber,
    required this.total,
    required this.status,
    required this.paymentStatus,
    this.trackingNumber,
    required this.createdAt,
  });
  
  factory OrderResult.fromJson(Map<String, dynamic> json) {
    return OrderResult(
      id: json['id'],
      orderNumber: json['order_number'],
      total: double.parse(json['total'].toString()),
      status: json['status'],
      paymentStatus: json['payment_status'],
      trackingNumber: json['tracking_number'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  @override
  List<Object?> get props => [
    id, 
    orderNumber, 
    total, 
    status, 
    paymentStatus, 
    trackingNumber, 
    createdAt
  ];
}