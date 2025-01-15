import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';
import '../../../routes/router.gr.dart';


class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
      child: Row(
        children: [
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              context.navigateTo(const HomeRoute());
            },
            style: ElevatedButton.styleFrom(elevation: 1),
            child: SvgPicture.asset(
              AppIcons.arrowForward,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
