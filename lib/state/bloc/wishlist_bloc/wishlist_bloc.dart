import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/categories/product.dart';
import '../../../repositories/wishlist_repository/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;

  WishlistBloc({required this.wishlistRepository})
      : super(WishlistInitial()) {
    on<WishlistStarted>(_onWishlistStarted);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<CheckWishlistStatus>(_onCheckWishlistStatus);
  }

  Future<void> _onWishlistStarted(
    WishlistStarted event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      final products = await wishlistRepository.getWishlist();
      final productWishlistStatus = <int, bool>{};
      
      // Set all products in wishlist to true
      for (var product in products) {
        if (product.id != null) {
          productWishlistStatus[product.id!] = true;
        }
      }
      
      emit(WishlistLoaded(
        products: products,
        productWishlistStatus: productWishlistStatus,
      ));
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    final currentState = state;
    if (currentState is WishlistLoaded && event.product.id != null) {
      try {
        final success = await wishlistRepository.addToWishlist(event.product.id!);
        if (success) {
          final updatedProducts = List<Product>.from(currentState.products);
          
          // Only add if not already in the list
          if (!updatedProducts.any((product) => product.id == event.product.id)) {
            updatedProducts.add(event.product);
          }
          
          // Update status map
          final updatedStatus = Map<int, bool>.from(currentState.productWishlistStatus);
          updatedStatus[event.product.id!] = true;
          
          emit(WishlistLoaded(
            products: updatedProducts,
            productWishlistStatus: updatedStatus,
          ));
        }
      } catch (e) {
        emit(WishlistError(message: e.toString()));
        emit(currentState); // Restore previous state after error
      }
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    final currentState = state;
    if (currentState is WishlistLoaded && event.product.id != null) {
      try {
        final success = await wishlistRepository.removeFromWishlist(event.product.id!);
        if (success) {
          final updatedProducts = currentState.products
              .where((product) => product.id != event.product.id)
              .toList();
              
          // Update status map
          final updatedStatus = Map<int, bool>.from(currentState.productWishlistStatus);
          updatedStatus[event.product.id!] = false;
          
          emit(WishlistLoaded(
            products: updatedProducts,
            productWishlistStatus: updatedStatus,
          ));
        }
      } catch (e) {
        emit(WishlistError(message: e.toString()));
        emit(currentState); // Restore previous state after error
      }
    }
  }

  Future<void> _onCheckWishlistStatus(
    CheckWishlistStatus event,
    Emitter<WishlistState> emit,
  ) async {
    final currentState = state;
    if (currentState is WishlistLoaded) {
      try {
        final isInWishlist = await wishlistRepository.isInWishlist(event.productId);
        
        // Only update the status map
        final updatedStatus = Map<int, bool>.from(currentState.productWishlistStatus);
        updatedStatus[event.productId] = isInWishlist;
        
        emit(currentState.copyWith(
          productWishlistStatus: updatedStatus,
        ));
      } catch (e) {
        // Just log the error but don't change state for status checks
        print('Error checking wishlist status: ${e.toString()}');
      }
    }
  }
}
