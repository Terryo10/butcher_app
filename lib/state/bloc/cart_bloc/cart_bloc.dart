import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/cart/cart_item.dart';
import '../../../models/cart/cart_model.dart';
import '../../../repositories/cart_repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  
  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<CartStarted>((event, emit) async {
      emit(CartLoading());
      try {
        final cart = await cartRepository.getCart();
        emit(CartLoaded(cart));
      } catch (e) {
        // Try to load local cart if online fails
        try {
          final localCart = await cartRepository.getLocalCart();
          if (localCart != null) {
            emit(CartLoaded(localCart));
          } else {
            emit(const CartLoaded(Cart()));
          }
        } catch (_) {
          emit(const CartLoaded(Cart()));
        }
      }
    });

    on<AddToCart>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoading());
        
        try {
          final updatedCart = await cartRepository.addToCart(
            event.productId, 
            event.quantity,
            name: event.name,
            price: event.price,
            image: event.image,
            unit: event.unit,
            pricingType: event.pricingType,
            unitPrice: event.unitPrice,
          );
          emit(CartLoaded(updatedCart, message: 'Item added to cart'));
          await cartRepository.saveCartLocally(updatedCart);
        } catch (e) {
          // Fallback to local cart update if API fails
          final existingItemIndex = currentState.cart.items.indexWhere(
            (item) => item.productId == event.productId
          );
          
          List<CartItem> updatedItems = List<CartItem>.from(currentState.cart.items);
          
          if (existingItemIndex >= 0) {
            // Update existing item
            final existingItem = currentState.cart.items[existingItemIndex];
            
            dynamic newQuantity;
            final isPricingTypeWeight = event.pricingType == 'weight' || existingItem.isWeightBased;
            
            if (isPricingTypeWeight) {
              // For weight-based products, add as double
              newQuantity = existingItem.quantityAsDouble + 
                (event.quantity is double ? event.quantity : double.parse(event.quantity.toString()));
            } else {
              // For fixed-price products, add as int
              newQuantity = (existingItem.quantity as int) + 
                (event.quantity is int ? event.quantity : int.parse(event.quantity.toString()));
            }
            
            final updatedItem = existingItem.copyWith(
              quantity: newQuantity,
              totalPrice: existingItem.price * 
                (newQuantity is double ? newQuantity : double.parse(newQuantity.toString())),
            );
            
            updatedItems[existingItemIndex] = updatedItem;
          } else {
            // Add new item
            final totalPrice = event.price * 
              (event.quantity is double ? event.quantity : double.parse(event.quantity.toString()));
            
            updatedItems.add(CartItem(
              id: DateTime.now().millisecondsSinceEpoch,
              name: event.name,
              price: event.price,
              quantity: event.quantity,
              image: event.image,
              productId: event.productId,
              unit: event.unit,
              pricingType: event.pricingType,
              unitPrice: event.price,
              totalPrice: totalPrice,
            ));
          }
          
          // Calculate total amount
          final totalAmount = updatedItems.fold(
            0.0, 
            (sum, item) => sum + item.calculatedTotalPrice,
          );
          
          final updatedCart = currentState.cart.copyWith(
            items: updatedItems,
            totalAmount: totalAmount,
            itemCount: updatedItems.length,
          );
          
          emit(CartLoaded(updatedCart, message: 'Item added to cart offline'));
          await cartRepository.saveCartLocally(updatedCart);
        }
      }
    });

    on<UpdateCartItem>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoading());
        
        try {
          final updatedCart = await cartRepository.updateCartItem(
            event.cartItemId, 
            event.quantity
          );
          emit(CartLoaded(updatedCart));
          await cartRepository.saveCartLocally(updatedCart);
        } catch (e) {
          // Fallback to local cart update if API fails
          List<CartItem> updatedItems = [];
          
          // Handle quantity <= 0 (remove item)
          if ((event.quantity is int && event.quantity <= 0) || 
              (event.quantity is double && event.quantity <= 0)) {
            updatedItems = currentState.cart.items
                .where((item) => item.id != event.cartItemId)
                .toList();
          } else {
            // Update quantity
            updatedItems = currentState.cart.items.map((item) {
              if (item.id == event.cartItemId) {
                final totalPrice = item.price * 
                  (event.quantity is double ? event.quantity : double.parse(event.quantity.toString()));
                
                return item.copyWith(
                  quantity: event.quantity,
                  totalPrice: totalPrice,
                );
              }
              return item;
            }).toList();
          }
          
          // Calculate total amount
          final totalAmount = updatedItems.fold(
            0.0, 
            (sum, item) => sum + item.calculatedTotalPrice,
          );
          
          final updatedCart = currentState.cart.copyWith(
            items: updatedItems,
            totalAmount: totalAmount,
            itemCount: updatedItems.length,
          );
          
          emit(CartLoaded(updatedCart, message: 'Cart updated offline'));
          await cartRepository.saveCartLocally(updatedCart);
        }
      }
    });

    on<RemoveFromCart>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoading());
        
        try {
          final updatedCart = await cartRepository.removeFromCart(event.cartItemId);
          emit(CartLoaded(updatedCart, message: 'Item removed from cart'));
          await cartRepository.saveCartLocally(updatedCart);
        } catch (e) {
          // Fallback to local cart update if API fails
          final updatedItems = currentState.cart.items
            .where((item) => item.id != event.cartItemId)
            .toList();
          
          // Calculate total amount
          final totalAmount = updatedItems.fold(
            0.0, 
            (sum, item) => sum + item.calculatedTotalPrice,
          );
          
          final updatedCart = currentState.cart.copyWith(
            items: updatedItems,
            totalAmount: totalAmount,
            itemCount: updatedItems.length,
          );
          
          emit(CartLoaded(updatedCart, message: 'Item removed from cart offline'));
          await cartRepository.saveCartLocally(updatedCart);
        }
      }
    });

    on<ApplyCoupon>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoading());
        
        try {
          final updatedCart = await cartRepository.applyCoupon(event.couponCode);
          emit(CartLoaded(updatedCart, message: 'Coupon applied successfully'));
          await cartRepository.saveCartLocally(updatedCart);
        } catch (e) {
          emit(const CartError('Failed to apply coupon. Please try again.'));
          await Future.delayed(const Duration(seconds: 1));
          emit(CartLoaded(currentState.cart));
        }
      }
    });

    on<RemoveCoupon>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        emit(CartLoading());
        
        try {
          final updatedCart = await cartRepository.removeCoupon();
          emit(CartLoaded(updatedCart, message: 'Coupon removed'));
          await cartRepository.saveCartLocally(updatedCart);
        } catch (e) {
          // Fallback to local coupon removal
          final updatedCart = currentState.cart.copyWith(
            couponCode: null,
            discountAmount: null,
          );
          
          emit(CartLoaded(updatedCart, message: 'Coupon removed offline'));
          await cartRepository.saveCartLocally(updatedCart);
        }
      }
    });

    on<ClearCart>((event, emit) async {
      if (state is CartLoaded) {
        emit(CartLoading());
        
        try {
          await cartRepository.clearCart();
          emit(const CartLoaded(Cart(), message: 'Cart cleared'));
          await cartRepository.saveCartLocally(const Cart());
        } catch (e) {
          // Fallback to local cart clear if API fails
          emit(const CartLoaded(Cart(), message: 'Cart cleared offline'));
          await cartRepository.saveCartLocally(const Cart());
        }
      }
    });
  }
}