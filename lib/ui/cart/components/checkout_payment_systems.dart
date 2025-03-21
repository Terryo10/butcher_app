import 'package:flutter/material.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';
import '../../../models/checkout/checkout_model.dart';
import 'checkout_payment_card_tile.dart';
import 'save_payment_method_tile.dart';

class PaymentSystem extends StatelessWidget {
  final PaymentType paymentType;
  final List<PaymentMethod> paymentMethods;
  final PaymentMethod? selectedPaymentMethod;
  final Function(PaymentMethod?, PaymentType) onPaymentMethodSelected;

  const PaymentSystem({
    super.key,
    required this.paymentType,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding / 2,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Payment Method',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PaymentCardTile(
                label: 'Credit/Debit Card',
                icon: AppIcons.masterCard,
                onTap: () => onPaymentMethodSelected(null, PaymentType.card),
                isActive: paymentType == PaymentType.card &&
                    selectedPaymentMethod == null,
              ),
              PaymentCardTile(
                label: 'PayPal',
                icon: AppIcons.paypal,
                onTap: () => onPaymentMethodSelected(null, PaymentType.paypal),
                isActive: paymentType == PaymentType.paypal,
              ),
              PaymentCardTile(
                label: 'Cash On Delivery',
                icon: AppIcons.cashOnDelivery,
                onTap: () =>
                    onPaymentMethodSelected(null, PaymentType.cashOnDelivery),
                isActive: paymentType == PaymentType.cashOnDelivery,
              ),
            ],
          ),
        ),

        // Saved payment methods (shown only for card payments)
        if (paymentType == PaymentType.card && paymentMethods.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDefaults.padding,
              vertical: AppDefaults.padding / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Saved Cards',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                ...paymentMethods.where((method) => method.type == 'card').map(
                      (method) => SavedPaymentMethodTile(
                        method: method,
                        isSelected: selectedPaymentMethod?.id == method.id,
                        onTap: () =>
                            onPaymentMethodSelected(method, PaymentType.card),
                      ),
                    ),
              ],
            ),
          ),
      ],
    );
  }
}
