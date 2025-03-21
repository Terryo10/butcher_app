import 'package:flutter/material.dart';

import '../../../constants/app_defaults.dart';
import '../../../core/components/dotted_divider.dart';
import '../../../models/cart/cart_model.dart';
import 'item_row.dart';

class ItemTotalsAndPrice extends StatelessWidget {
  const ItemTotalsAndPrice({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    // Count weight-based and fixed-price items
    final int totalItems = cart.items.length;
    final int weightBasedCount = cart.items.where((item) => item.isWeightBased).length;
    final int fixedPriceCount = totalItems - weightBasedCount;
    
    // Calculate subtotal, discount, and total
    final double subtotal = cart.calculatedTotalAmount;
    final double discount = cart.discountAmount ?? 0.0;
    final double total = cart.finalAmount;
    
    // Check if we have any weight-based items to show weight
    final bool hasWeightBasedItems = weightBasedCount > 0;
    
    // Calculate total weight if needed
    double totalWeight = 0.0;
    if (hasWeightBasedItems) {
      for (final item in cart.items) {
        if (item.isWeightBased) {
          totalWeight += item.quantityAsDouble;
        }
      }
    }
    
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Summary header
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          
          // Item counts
          if (fixedPriceCount > 0)
            ItemRow(
              title: 'Items',
              value: '$fixedPriceCount',
            ),
          
          // Weight items if present
          if (hasWeightBasedItems)
            ItemRow(
              title: 'Weight-Based Items',
              value: '$weightBasedCount',
            ),
          
          // Total weight if applicable
          if (hasWeightBasedItems)
            ItemRow(
              title: 'Total Weight',
              value: '${totalWeight.toStringAsFixed(2)} kg',
            ),
          
          // Subtotal
          ItemRow(
            title: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),
          
          // Discount if applicable
          if (discount > 0)
            ItemRow(
              title: 'Discount',
              value: '-\$${discount.toStringAsFixed(2)}',
              valueColor: Colors.green,
            ),
          
          const DottedDivider(),
          
          // Total price
          ItemRow(
            title: 'Total Price',
            value: '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }
}