import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';
import '../../../core/components/app_back_button.dart';
import '../../../core/components/app_radio.dart';


class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Delivery Address',
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Stack(
          children: [
            ListView.separated(
              itemBuilder: (context, index) {
                return AddressTile(
                  label: 'Puraton Custom, Chhatak',
                  address: '216/c East Road',
                  number: '+88017100710000',
                  isActive: index == 0,
                );
              },
              itemCount: 5,
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 0.2),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
   
                },
                backgroundColor: AppColors.primary,
                splashColor: AppColors.primary,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.address,
    required this.label,
    required this.number,
    required this.isActive,
  });

  final String address;
  final String label;
  final String number;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRadio(isActive: isActive),
          const SizedBox(width: AppDefaults.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 4),
              Text(address),
              const SizedBox(height: 4),
              Text(
                number,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.edit),
                constraints: const BoxConstraints(),
                iconSize: 14,
              ),
              const SizedBox(height: AppDefaults.margin / 2),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.deleteOutline),
                constraints: const BoxConstraints(),
                iconSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}