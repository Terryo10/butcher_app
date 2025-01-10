import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../constants/app_defaults.dart';
import 'components/dont_have_account_row.dart';
import 'components/login_header.dart';
import 'components/login_page_form.dart';
import 'components/social_logins.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginPageHeader(),
                LoginPageForm(),
                SizedBox(height: AppDefaults.padding),
                SocialLogins(),
                DontHaveAccountRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
