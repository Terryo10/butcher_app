import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';
import '../../../core/components/network_image.dart';
import '../../../models/cart/cart_item.dart';
import '../../../state/bloc/cart_bloc/cart_bloc.dart';
import '../../../static/app_urls.dart';

class SingleCartItemTile extends StatelessWidget {
  const SingleCartItemTile({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  // Check if item is weight-based
  bool get isWeightBased => cartItem.isWeightBased;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// Thumbnail
              SizedBox(
                width: 70,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    AppUrls.getProductImage(cartItem.image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              /// Quantity and Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (cartItem.unit != null)
                            Text(
                              isWeightBased
                                  ? cartItem.displayPrice
                                  : '${cartItem.unit}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                    
                    // Different quantity controls based on product type
                    isWeightBased 
                        ? _buildWeightQuantityControls(context)
                        : _buildFixedQuantityControls(context),
                  ],
                ),
              ),

              /// Price and Delete button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      _removeItem(context);
                    },
                    icon: SvgPicture.asset(AppIcons.delete),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${cartItem.calculatedTotalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )
            ],
          ),
          const Divider(thickness: 0.1),
        ],
      ),
    );
  }

  // Controls for fixed-price products
  Widget _buildFixedQuantityControls(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            final newQuantity = (cartItem.quantity as int) + 1;
            _updateQuantity(context, newQuantity);
          },
          icon: SvgPicture.asset(AppIcons.addQuantity),
          constraints: const BoxConstraints(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${cartItem.quantity}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        IconButton(
          onPressed: () {
            final currentQuantity = cartItem.quantity as int;
            if (currentQuantity > 1) {
              _updateQuantity(context, currentQuantity - 1);
            } else {
              _removeItem(context);
            }
          },
          icon: SvgPicture.asset(AppIcons.removeQuantity),
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  // Controls for weight-based products
  Widget _buildWeightQuantityControls(BuildContext context) {
    final double quantity = cartItem.quantityAsDouble;
    const double increment = 0.1; // Default increment
    
    return Row(
      children: [
        IconButton(
          onPressed: () {
            final newQuantity = quantity + increment;
            _updateQuantity(context, newQuantity);
          },
          icon: SvgPicture.asset(AppIcons.addQuantity),
          constraints: const BoxConstraints(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${quantity.toStringAsFixed(1)} ${cartItem.unit ?? ''}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (quantity > increment) {
              final newQuantity = quantity - increment;
              _updateQuantity(context, newQuantity);
            } else {
              _removeItem(context);
            }
          },
          icon: SvgPicture.asset(AppIcons.removeQuantity),
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  // Update item quantity
  void _updateQuantity(BuildContext context, dynamic newQuantity) {
    context.read<CartBloc>().add(
      UpdateCartItem(
        cartItemId: cartItem.id,
        quantity: newQuantity,
      ),
    );
  }

  // Remove item from cart
  void _removeItem(BuildContext context) {
    context.read<CartBloc>().add(
      RemoveFromCart(cartItemId: cartItem.id),
    );
  }
}