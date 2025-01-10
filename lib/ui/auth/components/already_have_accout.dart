import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already Have Account?'),
        TextButton(
          onPressed: () =>context.navigateTo(const LoginRoute()),
          child: const Text('Log In'),
        ),
      ],
    );
  }
}
