import 'package:flutter/material.dart';

import '../../../core/components/title_and_action_button.dart';

import '../../../models/checkout/checkout_model.dart';
import 'checkout_address_card.dart';

class AddressSelector extends StatelessWidget {
  final List<Address> addresses;
  final Address? selectedAddress;
  final Function(Address) onAddressSelected;
  final VoidCallback onAddNewAddress;

  const AddressSelector({
    super.key,
    required this.addresses,
    required this.selectedAddress,
    required this.onAddressSelected,
    required this.onAddNewAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Select Delivery Address',
          actionLabel: 'Add New',
          onTap: onAddNewAddress,
          isHeadline: false,
        ),
        if (addresses.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Text('No addresses found'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onAddNewAddress,
                    child: const Text('Add New Address'),
                  ),
                ],
              ),
            ),
          )
        else
          ...addresses.map((address) {
            final isSelected = selectedAddress?.id == address.id;
            return AddressCard(
              label: address.label,
              phoneNumber: address.phoneNumber,
              address: address.formattedAddress,
              isActive: isSelected,
              onTap: () => onAddressSelected(address),
            );
          }),
      ],
    );
  }
}