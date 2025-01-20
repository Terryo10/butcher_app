import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_defaults.dart';
import '../../../constants/app_icons.dart';
import '../../../state/bloc/auth_bloc/auth_bloc.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: state is AuthLoadingState
                      ? null
                      : () => context.read<AuthBloc>().add(LoginWithGoogle()),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding * 2,
                      vertical: AppDefaults.padding,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.googleIconRounded,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Google',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppDefaults.margin),
              if(Platform.isIOS)
              Expanded(
                child: OutlinedButton(
                  onPressed: state is AuthLoadingState
                      ? null
                      : () => context.read<AuthBloc>().add(LoginWithApple()),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding * 2,
                      vertical: AppDefaults.padding,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.appleIconRounded,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Apple',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}