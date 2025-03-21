part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {}

class AddToCart extends CartEvent {
  final int productId;
  final dynamic quantity; // Can be int or double based on product type
  final String name;
  final double price;
  final String image;
  final String? unit;
  final String? pricingType;
  final double? unitPrice;

  const AddToCart({
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    required this.image,
    this.unit,
    this.pricingType = 'fixed',
    this.unitPrice,
  });

  @override
  List<Object?> get props => [
    productId, 
    quantity, 
    name, 
    price, 
    image, 
    unit, 
    pricingType, 
    unitPrice
  ];
}

class UpdateCartItem extends CartEvent {
  final int cartItemId;
  final dynamic quantity; // Can be int or double based on product type

  const UpdateCartItem({
    required this.cartItemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [cartItemId, quantity];
}

class RemoveFromCart extends CartEvent {
  final int cartItemId;

  const RemoveFromCart({
    required this.cartItemId,
  });

  @override
  List<Object> get props => [cartItemId];
}

class ApplyCoupon extends CartEvent {
  final String couponCode;

  const ApplyCoupon({
    required this.couponCode,
  });

  @override
  List<Object> get props => [couponCode];
}

class RemoveCoupon extends CartEvent {}

class ClearCart extends CartEvent {}