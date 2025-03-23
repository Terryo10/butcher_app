import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/cart/cart_model.dart';
import '../../../models/checkout/checkout_model.dart';
import '../../../repositories/cart_repository/cart_repository.dart';
import '../../../repositories/checkout_repository/checkout_repository.dart';


part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository checkoutRepository;
  final CartRepository cartRepository;
  
  CheckoutBloc({
    required this.checkoutRepository,
    required this.cartRepository,
  }) : super(CheckoutInitial()) {
    on<CheckoutStarted>((event, emit) async {
      emit(CheckoutLoading());
      try {
        final cart = await cartRepository.getCart();
        final addresses = await checkoutRepository.getAddresses();
        final paymentMethods = await checkoutRepository.getSavedPaymentMethods();
        
        emit(CheckoutLoaded(
          cart: cart,
          addresses: addresses,
          paymentMethods: paymentMethods,
          selectedAddress: addresses.isNotEmpty ? addresses.first : null,
          selectedPaymentMethod: paymentMethods.isNotEmpty ? paymentMethods.first : null,
          paymentType: PaymentType.card,
        ));
      } catch (e) {
        emit(CheckoutError('Failed to load checkout data: $e'));
      }
    });

    on<AddressSelected>((event, emit) {
      if (state is CheckoutLoaded) {
        final currentState = state as CheckoutLoaded;
        emit(currentState.copyWith(selectedAddress: event.address));
      }
    });

    on<PaymentMethodSelected>((event, emit) {
      if (state is CheckoutLoaded) {
        final currentState = state as CheckoutLoaded;
        emit(currentState.copyWith(
          selectedPaymentMethod: event.paymentMethod,
          paymentType: event.paymentType,
        ));
      }
    });

    on<PlaceOrder>((event, emit) async {
      if (state is CheckoutLoaded) {
        final currentState = state as CheckoutLoaded;
        emit(CheckoutProcessing());
        
        try {
          // Validate required data
          if (currentState.selectedAddress == null) {
            throw Exception('Please select a delivery address');
          }
          
          if (currentState.paymentType == PaymentType.card && 
              currentState.selectedPaymentMethod == null && 
              event.cardDetails == null) {
            throw Exception('Please enter payment details');
          }
          
          // Process the order
          final orderResult = await checkoutRepository.placeOrder(
            cart: currentState.cart,
            addressId: currentState.selectedAddress!.id,
            paymentType: currentState.paymentType,
            paymentMethodId: currentState.selectedPaymentMethod?.id,
            cardDetails: event.cardDetails,
            saveCard: event.saveCard,
          );
          
          // Clear cart after successful order
          await cartRepository.clearCart();
          
          emit(CheckoutSuccess(orderResult));
        } catch (e) {
          emit(CheckoutError(e.toString()));
          // Revert to loaded state after error
          await Future.delayed(const Duration(seconds: 1));
          emit(currentState);
        }
      }
    });
    
    on<AddNewAddress>((event, emit) async {
      if (state is CheckoutLoaded) {
        final currentState = state as CheckoutLoaded;
        emit(const CheckoutProcessingAction("Adding new address..."));
        
        try {
          final newAddress = await checkoutRepository.addAddress(event.address);
          final updatedAddresses = List<Address>.from(currentState.addresses)..add(newAddress);
          
          emit(CheckoutLoaded(
            cart: currentState.cart,
            addresses: updatedAddresses,
            paymentMethods: currentState.paymentMethods,
            selectedAddress: newAddress, // Select the newly added address
            selectedPaymentMethod: currentState.selectedPaymentMethod,
            paymentType: currentState.paymentType,
          ));
        } catch (e) {
          emit(CheckoutError('Failed to add address: $e'));
          // Revert to loaded state after error
          await Future.delayed(const Duration(seconds: 1));
          emit(currentState);
        }
      }
    });
  }
}