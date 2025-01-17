import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';

import '../../../state/bloc/auth_bloc/auth_bloc.dart';
import '../../../themes/app_themes.dart';
import 'login_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});



  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordShown = false;
  bool isEmailMode = true;
  String? _completePhoneNumber;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  void toggleInputMode() {
    setState(() {
      isEmailMode = !isEmailMode;
      // Clear the input field when switching modes
      _emailController.clear();
      _phoneController.clear();
      _completePhoneNumber = null;
    });
  }

  void onLogin() {
    if (_key.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(LoginWithCredentials(
        identifier: isEmailMode ? _emailController.text : _completePhoneNumber ?? '',
        password: _passwordController.text,
      ));
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);
    if (!emailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? phoneValidator(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) {
      return 'Please enter your phone number';
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
        } else if (state is AuthInitial) {
          context.router.replaceAll([const OnboardingRoute()]);
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
                  // Custom toggle button
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _CustomToggleButton(
                          text: 'Email',
                          isSelected: isEmailMode,
                          onTap: () {
                            if (!isEmailMode) toggleInputMode();
                          },
                        ),
                        _CustomToggleButton(
                          text: 'Phone',
                          isSelected: !isEmailMode,
                          onTap: () {
                            if (isEmailMode) toggleInputMode();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  // Dynamic input field based on mode
                  Text(isEmailMode ? "Email" : "Phone Number"),
                  const SizedBox(height: 8),
                  if (isEmailMode)
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                    )
                  else
                    IntlPhoneField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                      ),
                      onChanged: (phone) {
                        setState(() {
                          _completePhoneNumber = phone.completeNumber;
                        });
                      },
                      initialCountryCode: 'US',
                      textInputAction: TextInputAction.next,
                      disableLengthCheck: true,
                      invalidNumberMessage: 'Please enter a valid phone number',
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

class _CustomToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _CustomToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}