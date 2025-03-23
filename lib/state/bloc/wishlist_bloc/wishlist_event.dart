part of 'wishlist_bloc.dart';


abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class WishlistStarted extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final Product product;

  const AddToWishlist({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromWishlist extends WishlistEvent {
  final Product product;

  const RemoveFromWishlist({required this.product});

  @override
  List<Object> get props => [product];
}

class CheckWishlistStatus extends WishlistEvent {
  final int productId;

  const CheckWishlistStatus({required this.productId});

  @override
  List<Object> get props => [productId];
}
