
import 'package:butcher_app/models/categories/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/bloc/wishlist_bloc/wishlist_bloc.dart';

class WishlistButton extends StatelessWidget {
  final Product product;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  const WishlistButton({
    super.key,
    required this.product,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.grey,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    // Check product wishlist status when widget is built
    if (product.id != null) {
      context.read<WishlistBloc>().add(
            CheckWishlistStatus(productId: product.id!),
          );
    }

    return BlocBuilder<WishlistBloc, WishlistState>(
      buildWhen: (previous, current) {
        // Only rebuild when the wishlist status for this product changes
        if (previous is WishlistLoaded && current is WishlistLoaded && product.id != null) {
          return previous.isInWishlist(product.id!) != 
                 current.isInWishlist(product.id!);
        }
        return true;
      },
      builder: (context, state) {
        bool isInWishlist = false;
        
        if (state is WishlistLoaded && product.id != null) {
          isInWishlist = state.isInWishlist(product.id!);
        }
        
        return IconButton(
          icon: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_border,
            color: isInWishlist ? activeColor : inactiveColor,
            size: size,
          ),
          onPressed: () {
            if (product.id == null) return; // Skip if product has no ID
            
            if (isInWishlist) {
              context.read<WishlistBloc>().add(
                    RemoveFromWishlist(product: product),
                  );
            } else {
              context.read<WishlistBloc>().add(
                    AddToWishlist(product: product),
                  );
            }
          },
        );
      },
    );
  }
}