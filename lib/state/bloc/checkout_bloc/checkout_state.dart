

part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
  
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutProcessing extends CheckoutState {}

class CheckoutProcessingAction extends CheckoutState {
  final String message;
  
  const CheckoutProcessingAction(this.message);
  
  @override
  List<Object> get props => [message];
}

class CheckoutLoaded extends CheckoutState {
  final Cart cart;
  final List<Address> addresses;
  final List<PaymentMethod> paymentMethods;
  final Address? selectedAddress;
  final PaymentMethod? selectedPaymentMethod;
  final PaymentType paymentType;
  
  const CheckoutLoaded({
    required this.cart,
    required this.addresses,
    required this.paymentMethods,
    this.selectedAddress,
    this.selectedPaymentMethod,
    required this.paymentType,
  });
  
  CheckoutLoaded copyWith({
    Cart? cart,
    List<Address>? addresses,
    List<PaymentMethod>? paymentMethods,
    Address? selectedAddress,
    PaymentMethod? selectedPaymentMethod,
    PaymentType? paymentType,
  }) {
    return CheckoutLoaded(
      cart: cart ?? this.cart,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      paymentType: paymentType ?? this.paymentType,
    );
  }
  
  @override
  List<Object?> get props => [
    cart, 
    addresses, 
    paymentMethods, 
    selectedAddress, 
    selectedPaymentMethod,
    paymentType
  ];
}

class CheckoutSuccess extends CheckoutState {
  final OrderResult orderResult;
  
  const CheckoutSuccess(this.orderResult);
  
  @override
  List<Object> get props => [orderResult];
}

class CheckoutError extends CheckoutState {
  final String message;
  
  const CheckoutError(this.message);
  
  @override
  List<Object> get props => [message];
}