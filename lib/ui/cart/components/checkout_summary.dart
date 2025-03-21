import 'package:flutter/material.dart';
import '../../../constants/app_defaults.dart';
import '../../../models/cart/cart_item.dart';
import '../../../models/cart/cart_model.dart';

class CheckoutSummary extends StatelessWidget {
  final Cart cart;

  const CheckoutSummary({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      margin: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppDefaults.radius),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          // Items and prices
          ...cart.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name} x ${_formatQuantity(item)}',
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '\$${item.calculatedTotalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
          const Divider(),
          // Subtotal
          Row(
            children: [
              const Text('Subtotal'),
              const Spacer(),
              Text(
                '\$${cart.calculatedTotalAmount.toStringAsFixed(2)}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Shipping
          Row(
            children: [
              const Text('Shipping'),
              const Spacer(),
              Text(
                _calculateShipping(cart) > 0
                    ? '\$${_calculateShipping(cart).toStringAsFixed(2)}'
                    : 'Free',
                style: TextStyle(
                  color: _calculateShipping(cart) > 0
                      ? Colors.black
                      : Colors.green,
                ),
              ),
            ],
          ),
          // Discount if applicable
          if (cart.discountAmount != null && cart.discountAmount! > 0) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Discount ${cart.couponCode != null ? '(${cart.couponCode})' : ''}',
                  style: const TextStyle(color: Colors.green),
                ),
                const Spacer(),
                Text(
                  '-\$${cart.discountAmount!.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          // Tax
          Row(
            children: [
              const Text('Tax'),
              const Spacer(),
              Text(
                '\$${_calculateTax(cart).toStringAsFixed(2)}',
              ),
            ],
          ),
          const Divider(),
          // Total
          Row(
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                '\$${_calculateTotal(cart).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatQuantity(CartItem item) {
    if (item.isWeightBased) {
      return '${item.quantity} ${item.unit}';
    }
    return item.quantity.toString();
  }

  double _calculateShipping(Cart cart) {
    // Apply free shipping for orders over $50
    if (cart.calculatedTotalAmount >= 50) {
      return 0;
    }

    // Base shipping cost
    return 5.99;
  }

  double _calculateTax(Cart cart) {
    // Example tax calculation - typically this would come from the backend
    // Here we're using a simple 10% tax rate
    const taxRate = 0.1;
    final taxableAmount =
        cart.calculatedTotalAmount - (cart.discountAmount ?? 0);
    return taxableAmount * taxRate;
  }

  double _calculateTotal(Cart cart) {
    final subtotal = cart.calculatedTotalAmount;
    final shipping = _calculateShipping(cart);
    final discount = cart.discountAmount ?? 0;
    final tax = _calculateTax(cart);

    return subtotal + shipping - discount + tax;
  }
}
