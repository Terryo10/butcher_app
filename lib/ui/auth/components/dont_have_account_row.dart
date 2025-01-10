import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../routes/router.gr.dart';


class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t Have Account?'),
        TextButton(
          onPressed: () => context.navigateTo(const SignUpRoute()),
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
