part of 'checkout_bloc.dart';

// Events
abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutStarted extends CheckoutEvent {}

class AddressSelected extends CheckoutEvent {
  final Address address;
  
  const AddressSelected(this.address);
  
  @override
  List<Object> get props => [address];
}

class PaymentMethodSelected extends CheckoutEvent {
  final PaymentMethod? paymentMethod;
  final PaymentType paymentType;
  
  const PaymentMethodSelected({
    this.paymentMethod,
    required this.paymentType,
  });
  
  @override
  List<Object?> get props => [paymentMethod, paymentType];
}

class AddNewAddress extends CheckoutEvent {
  final Address address;
  
  const AddNewAddress(this.address);
  
  @override
  List<Object> get props => [address];
}

class PlaceOrder extends CheckoutEvent {
  final CardDetails? cardDetails;
  final bool saveCard;
  
  const PlaceOrder({
    this.cardDetails,
    this.saveCard = false,
  });
  
  @override
  List<Object?> get props => [cardDetails, saveCard];
}
