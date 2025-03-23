import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';
import 'package:butcher_app/state/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/app_back_button.dart';

import '../../models/checkout/checkout_model.dart';
import 'components/checkout_address_selector.dart';
import 'components/checkout_card_details.dart';
import 'components/checkout_payment_systems.dart';
import 'components/checkout_summary.dart';
import 'components/paynow_button.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _cardFormKey = GlobalKey<FormState>();
  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _saveCard = true;

  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(CheckoutStarted());
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Checkout'),
      ),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CheckoutSuccess) {
            // Navigate to order success page
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully!')),
            );
            // Navigate to order success page
            context.navigateTo(
              OrderSuccessRoute(
                orderResult: state.orderResult,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CheckoutLoading || state is CheckoutProcessing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CheckoutProcessingAction) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(state.message),
                ],
              ),
            );
          }

          if (state is CheckoutLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AddressSelector(
                    addresses: state.addresses,
                    selectedAddress: state.selectedAddress,
                    onAddressSelected: (address) {
                      context
                          .read<CheckoutBloc>()
                          .add(AddressSelected(address));
                    },
                    onAddNewAddress: () {
                      // Show dialog to add new address
                      _showAddAddressDialog(context);
                    },
                  ),
                  PaymentSystem(
                    paymentType: state.paymentType,
                    paymentMethods: state.paymentMethods,
                    selectedPaymentMethod: state.selectedPaymentMethod,
                    onPaymentMethodSelected: (paymentMethod, paymentType) {
                      context.read<CheckoutBloc>().add(
                            PaymentMethodSelected(
                              paymentMethod: paymentMethod,
                              paymentType: paymentType,
                            ),
                          );
                    },
                  ),
                  if (state.paymentType == PaymentType.card &&
                      state.selectedPaymentMethod == null)
                    CheckOutCardDetails(
                      formKey: _cardFormKey,
                      cardNameController: _cardNameController,
                      cardNumberController: _cardNumberController,
                      expiryController: _expiryController,
                      cvvController: _cvvController,
                      saveCard: _saveCard,
                      onSaveCardChanged: (value) {
                        setState(() {
                          _saveCard = value;
                        });
                      },
                    ),
                  CheckoutSummary(cart: state.cart),
                  PayNowButton(
                    onPressed: () {
                      if (state.paymentType == PaymentType.card &&
                          state.selectedPaymentMethod == null &&
                          !_validateCardForm()) {
                        return;
                      }

                      CardDetails? cardDetails;
                      if (state.paymentType == PaymentType.card &&
                          state.selectedPaymentMethod == null) {
                        cardDetails = CardDetails(
                          cardName: _cardNameController.text,
                          cardNumber: _cardNumberController.text,
                          expirationDate: _expiryController.text,
                          cvv: _cvvController.text,
                        );
                      }

                      context.read<CheckoutBloc>().add(
                            PlaceOrder(
                              cardDetails: cardDetails,
                              saveCard: _saveCard,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }

          return const Center(
            child: Text('Something went wrong. Please try again later.'),
          );
        },
      ),
    );
  }

  bool _validateCardForm() {
    if (_cardFormKey.currentState == null) return false;
    return _cardFormKey.currentState!.validate();
  }

  void _showAddAddressDialog(BuildContext context) {
    // This is a simple version - in a real app, you would create a more detailed form
    TextEditingController labelController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressLine1Controller = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController zipController = TextEditingController();
    String country = 'United States';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration: const InputDecoration(
                    labelText: 'Label (e.g. Home, Office)'),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: addressLine1Controller,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: stateController,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: zipController,
                decoration: const InputDecoration(labelText: 'ZIP/Postal Code'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Basic validation
              if (labelController.text.isEmpty ||
                  nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  addressLine1Controller.text.isEmpty ||
                  cityController.text.isEmpty ||
                  stateController.text.isEmpty ||
                  zipController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }

              // Create new address model
              final newAddress = Address(
                id: -1, // Temporary ID, will be replaced by server
                label: labelController.text,
                fullName: nameController.text,
                phoneNumber: phoneController.text,
                addressLine1: addressLine1Controller.text,
                city: cityController.text,
                state: stateController.text,
                postalCode: zipController.text,
                country: country,
              );

              // Add new address
              context.read<CheckoutBloc>().add(AddNewAddress(newAddress));

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
