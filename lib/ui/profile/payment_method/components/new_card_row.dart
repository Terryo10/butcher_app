import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_defaults.dart';
import '../../../../constants/app_icons.dart';

class AddNewCardRow extends StatelessWidget {
  const AddNewCardRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Row(
        children: [
          Text(
            'My Card',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
          
            },
            icon: SvgPicture.asset(AppIcons.cardAdd),
          )
        ],
      ),
    );
  }
}
