// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:butcher_app/onboarding/onboarding_page.dart' as _i8;
import 'package:butcher_app/ui/auth/forget_password_page.dart' as _i1;
import 'package:butcher_app/ui/auth/intro_login_page.dart' as _i3;
import 'package:butcher_app/ui/auth/login_or_signup_page.dart' as _i5;
import 'package:butcher_app/ui/auth/login_page.dart' as _i6;
import 'package:butcher_app/ui/auth/number_verification_page.dart' as _i7;
import 'package:butcher_app/ui/auth/password_reset_page.dart' as _i9;
import 'package:butcher_app/ui/auth/sign_up_page.dart' as _i11;
import 'package:butcher_app/ui/home_page.dart' as _i2;
import 'package:butcher_app/ui/landing/landing_page.dart' as _i4;
import 'package:butcher_app/ui/products/product_details_page.dart' as _i10;
import 'package:flutter/material.dart' as _i13;

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i12.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.IntroLoginPage]
class IntroLoginRoute extends _i12.PageRouteInfo<void> {
  const IntroLoginRoute({List<_i12.PageRouteInfo>? children})
      : super(
          IntroLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroLoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.IntroLoginPage();
    },
  );
}

/// generated route for
/// [_i4.LandingPage]
class LandingRoute extends _i12.PageRouteInfo<void> {
  const LandingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.LandingPage();
    },
  );
}

/// generated route for
/// [_i5.LoginOrSignUpPage]
class LoginOrSignUpRoute extends _i12.PageRouteInfo<void> {
  const LoginOrSignUpRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginOrSignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginOrSignUpRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginOrSignUpPage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.NumberVerificationPage]
class NumberVerificationRoute extends _i12.PageRouteInfo<void> {
  const NumberVerificationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NumberVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NumberVerificationRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.NumberVerificationPage();
    },
  );
}

/// generated route for
/// [_i8.OnboardingPage]
class OnboardingRoute extends _i12.PageRouteInfo<void> {
  const OnboardingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i9.PasswordResetPage]
class PasswordResetRoute extends _i12.PageRouteInfo<void> {
  const PasswordResetRoute({List<_i12.PageRouteInfo>? children})
      : super(
          PasswordResetRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordResetRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.PasswordResetPage();
    },
  );
}

/// generated route for
/// [_i10.ProductDetailsPage]
class ProductDetailsRoute extends _i12.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i13.Key? key,
    required dynamic product,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i10.ProductDetailsPage(
        key: args.key,
        product: args.product,
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.product,
  });

  final _i13.Key? key;

  final dynamic product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i11.SignUpPage]
class SignUpRoute extends _i12.PageRouteInfo<void> {
  const SignUpRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SignUpPage();
    },
  );
}
