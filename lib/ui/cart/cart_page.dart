import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_defaults.dart';
import '../../core/components/app_back_button.dart';
import '../../state/bloc/cart_bloc/cart_bloc.dart';

import 'components/coupon_code_field.dart';
import 'components/items_totals_price.dart';
import 'components/single_cart_item_tile.dart';
import 'components/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isHomePage
          ? null
          : AppBar(
              leading: const AppBackButton(),
              title: const Text('Cart'),
              actions: [
                // Clear cart button
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded && state.cart.items.isNotEmpty) {
                      return IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          _showClearCartConfirmation(context);
                        },
                        tooltip: 'Clear Cart',
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            if (state is CartError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading cart',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(state.message),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(CartStarted());
                        },
                        child: const Text('Try Again'),
                      )
                    ],
                  ),
                ),
              );
            }
            
            if (state is CartLoaded) {
              if (state.cart.items.isEmpty) {
                return const EmptyCart();
              }
              
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Cart items
                    ...state.cart.items.map((item) => SingleCartItemTile(
                      cartItem: item,
                    )),
                    
                    // Coupon field
                    CouponCodeField(
                      appliedCoupon: state.cart.couponCode,
                      onApply: (couponCode) {
                        context.read<CartBloc>().add(
                          ApplyCoupon(couponCode: couponCode),
                        );
                      },
                      onRemove: () {
                        context.read<CartBloc>().add(RemoveCoupon());
                      },
                    ),
                    
                    // Totals and summary
                    ItemTotalsAndPrice(cart: state.cart),
                    
                    // Checkout button
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: ElevatedButton(
                          onPressed: state.cart.items.isEmpty 
                              ? null
                              : () {
                                  context.router.pushNamed('/checkout');
                                },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            // Initial state or unexpected state
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
  
  void _showClearCartConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<CartBloc>().add(ClearCart());
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}