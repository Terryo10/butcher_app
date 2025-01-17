import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';

import '../../../state/bloc/auth_bloc/auth_bloc.dart';
import '../../../themes/app_themes.dart';
import 'login_button.dart';
class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordShown = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  void onLogin() {
    if (_key.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(LoginWithCredentials(
        identifier: _identifierController.text,
        password: _passwordController.text,
      ));
    }
  }

  String? identifierValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number or email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticatedState) {
          context.navigateTo(const HomeRoute());
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Theme(
          data: AppTheme.defaultTheme.copyWith(
            inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Phone Number or Email"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _identifierController,
                    keyboardType: TextInputType.text,
                    validator: identifierValidator,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number or email',
                    ),
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  const Text("Password"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    validator: passwordValidator,
                    onFieldSubmitted: (v) => onLogin(),
                    textInputAction: TextInputAction.done,
                    obscureText: !isPasswordShown,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: onPassShowClicked,
                          icon: SvgPicture.asset(
                            AppIcons.eye,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.navigateTo(const ForgotPasswordRoute());
                      },
                      child: const Text('Forget Password?'),
                    ),
                  ),

                  if (state is AuthLoadingState)
                    const Center(child: CircularProgressIndicator())
                  else
                    LoginButton(onPressed: onLogin),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}