part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}
class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;
  final String? message;
  
  const CartLoaded(this.cart, {this.message});
  
  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final String message;
  
  const CartError(this.message);
  
  @override
  List<Object> get props => [message];
}

class SynchronizeCart extends CartEvent {
  const SynchronizeCart();
}

class PrepareForCheckout extends CartEvent {
  const PrepareForCheckout();
}

// Add a new state for checkout preparation
class CheckoutPreparing extends CartState {
  const CheckoutPreparing();
}
