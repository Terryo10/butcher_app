import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../models/order_model.dart';

class OrderProductItem extends StatelessWidget {
  final OrderItem item;

  const OrderProductItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image placeholder
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.image, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),

        // Product details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '\$ ${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                  const Text(' × '),
                  Text(
                    _formatQuantity(item),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Total price
         Text(
          '\$ ${item.totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  String _formatQuantity(OrderItem item) {
    final quantity = item.quantity;
    final unit = item.unit ?? '';

    // If pricing by weight, format differently
    if (item.pricingType?.toLowerCase() == 'weight' && unit.isNotEmpty) {
      return '$quantity $unit';
    }

    return quantity;
  }
}
