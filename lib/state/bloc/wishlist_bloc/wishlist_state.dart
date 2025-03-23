part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  
  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> products;
  final Map<int, bool> productWishlistStatus;

  const WishlistLoaded({
    required this.products,
    this.productWishlistStatus = const {},
  });

  @override
  List<Object> get props => [products, productWishlistStatus];

  WishlistLoaded copyWith({
    List<Product>? products,
    Map<int, bool>? productWishlistStatus,
  }) {
    return WishlistLoaded(
      products: products ?? this.products,
      productWishlistStatus: productWishlistStatus ?? this.productWishlistStatus,
    );
  }

  bool isInWishlist(int productId) {
    return productWishlistStatus[productId] ?? false;
  }
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError({required this.message});

  @override
  List<Object> get props => [message];
}
