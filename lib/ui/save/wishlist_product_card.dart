import 'package:butcher_app/models/categories/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/network_image.dart';

import '../../state/bloc/wishlist_bloc/wishlist_bloc.dart';
import '../../state/bloc/cart_bloc/cart_bloc.dart';

class WishlistProductCard extends StatelessWidget {
  final Product product;

  const WishlistProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  // Product Image
                  NetworkImageWithLoader(
                    product.image ?? '',
                    fit: BoxFit.cover,
                  ),
                  
                  // Wishlist Remove Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        iconSize: 20,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          context.read<WishlistBloc>().add(
                                RemoveFromWishlist(product: product),
                              );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Product Info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? 'Product',
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.formattedPrice,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                
                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Determine initial quantity based on pricing type
                      final initialQuantity = product.isWeightBased
                          ? product.minQuantityAsDouble ?? 0.5
                          : 1;
                      
                      // Add product to cart using the correct AddToCart event
                      context.read<CartBloc>().add(
                            AddToCart(
                              productId: product.id ?? 0,
                              quantity: initialQuantity,
                              name: product.name ?? 'Product',
                              price: product.priceAsDouble,
                              image: product.image ?? '',
                              unit: product.unit,
                              pricingType: product.pricingType,
                              unitPrice: product.priceAsDouble,
                            ),
                          );
                          
                      // Show confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}