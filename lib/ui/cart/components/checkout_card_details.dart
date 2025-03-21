import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_defaults.dart';
import '../../../utils/validators.dart';

class CheckOutCardDetails extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNameController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final bool saveCard;
  final Function(bool) onSaveCardChanged;

  const CheckOutCardDetails({
    super.key,
    required this.formKey,
    required this.cardNameController,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
    required this.saveCard,
    required this.onSaveCardChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            const Text("Card Name"),
            const SizedBox(height: 8),
            TextFormField(
              controller: cardNameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Name on card',
                prefixIcon: Icon(Icons.person),
              ),
              validator: Validators.requiredWithFieldName('Card name'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppDefaults.padding),

            // Number Field
            const Text("Card Number"),
            const SizedBox(height: 8),
            TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'XXXX XXXX XXXX XXXX',
                prefixIcon: Icon(Icons.credit_card),
              ),
              validator: Validators.validateCardNumber,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                // Format card number with spaces every 4 digits
                if (value.isNotEmpty) {
                  String formatted = value.replaceAll(' ', '');
                  formatted = formatted.replaceAllMapped(
                    RegExp(r'.{4}'),
                    (match) => '${match.group(0)} ',
                  );
                  if (formatted != value) {
                    cardNumberController.value = TextEditingValue(
                      text: formatted.trim(),
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: AppDefaults.padding),

            /* <---- Expiration Date And CVV -----> */
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Expiration Date"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: expiryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'MM/YY',
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        validator: Validators.validateExpiryDate,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          // Format as MM/YY
                          if (value.isNotEmpty) {
                            if (value.length == 2 && !value.contains('/')) {
                              expiryController.text = '$value/';
                              expiryController.selection = TextSelection.fromPosition(
                                TextPosition(offset: expiryController.text.length),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CVV"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'XXX',
                          prefixIcon: Icon(Icons.security),
                        ),
                        validator: Validators.validateCVV,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        maxLength: 4,
                        buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDefaults.padding),

            Row(
              children: [
                Text(
                  'Remember My Card Details',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: saveCard,
                  onChanged: onSaveCardChanged,
                  activeColor: Theme.of(context).primaryColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}