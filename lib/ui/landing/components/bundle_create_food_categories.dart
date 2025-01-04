import 'package:flutter/material.dart';

import '../../../constants/app_defaults.dart';
import 'app_chip.dart';

class FoodCategories extends StatelessWidget {
  const FoodCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
      ),
      child: Row(
        children: [
          AppChip(
            isActive: true,
            label: 'Vegetables',
            onPressed: () {},
          ),
          AppChip(
            isActive: false,
            label: 'Meat & Fish',
            onPressed: () {},
          ),
          AppChip(
            isActive: false,
            label: 'Medicine',
            onPressed: () {},
          ),
          AppChip(
            isActive: false,
            label: 'Baby Care',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
