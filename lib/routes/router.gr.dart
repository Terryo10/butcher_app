// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:butcher_app/core/components/product_details_page.dart' as _i12;
import 'package:butcher_app/onboarding/onboarding_page.dart' as _i10;
import 'package:butcher_app/ui/auth/forget_password_page.dart' as _i3;
import 'package:butcher_app/ui/auth/intro_login_page.dart' as _i5;
import 'package:butcher_app/ui/auth/login_or_signup_page.dart' as _i7;
import 'package:butcher_app/ui/auth/login_page.dart' as _i8;
import 'package:butcher_app/ui/auth/number_verification_page.dart' as _i9;
import 'package:butcher_app/ui/auth/password_reset_page.dart' as _i11;
import 'package:butcher_app/ui/auth/sign_up_page.dart' as _i13;
import 'package:butcher_app/ui/cart/cart_page.dart' as _i1;
import 'package:butcher_app/ui/cart/checkout_page.dart' as _i2;
import 'package:butcher_app/ui/home_page.dart' as _i4;
import 'package:butcher_app/ui/landing/landing_page.dart' as _i6;
import 'package:flutter/material.dart' as _i15;

/// generated route for
/// [_i1.CartPage]
class CartRoute extends _i14.PageRouteInfo<CartRouteArgs> {
  CartRoute({
    _i15.Key? key,
    bool isHomePage = false,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          CartRoute.name,
          args: CartRouteArgs(
            key: key,
            isHomePage: isHomePage,
          ),
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<CartRouteArgs>(orElse: () => const CartRouteArgs());
      return _i1.CartPage(
        key: args.key,
        isHomePage: args.isHomePage,
      );
    },
  );
}

class CartRouteArgs {
  const CartRouteArgs({
    this.key,
    this.isHomePage = false,
  });

  final _i15.Key? key;

  final bool isHomePage;

  @override
  String toString() {
    return 'CartRouteArgs{key: $key, isHomePage: $isHomePage}';
  }
}

/// generated route for
/// [_i2.CheckoutPage]
class CheckoutRoute extends _i14.PageRouteInfo<void> {
  const CheckoutRoute({List<_i14.PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.CheckoutPage();
    },
  );
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordRoute extends _i14.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.IntroLoginPage]
class IntroLoginRoute extends _i14.PageRouteInfo<void> {
  const IntroLoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          IntroLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroLoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.IntroLoginPage();
    },
  );
}

/// generated route for
/// [_i6.LandingPage]
class LandingRoute extends _i14.PageRouteInfo<void> {
  const LandingRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.LandingPage();
    },
  );
}

/// generated route for
/// [_i7.LoginOrSignUpPage]
class LoginOrSignUpRoute extends _i14.PageRouteInfo<void> {
  const LoginOrSignUpRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginOrSignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginOrSignUpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginOrSignUpPage();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginPage();
    },
  );
}

/// generated route for
/// [_i9.NumberVerificationPage]
class NumberVerificationRoute extends _i14.PageRouteInfo<void> {
  const NumberVerificationRoute({List<_i14.PageRouteInfo>? children})
      : super(
          NumberVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NumberVerificationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.NumberVerificationPage();
    },
  );
}

/// generated route for
/// [_i10.OnboardingPage]
class OnboardingRoute extends _i14.PageRouteInfo<void> {
  const OnboardingRoute({List<_i14.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i11.PasswordResetPage]
class PasswordResetRoute extends _i14.PageRouteInfo<void> {
  const PasswordResetRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PasswordResetRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordResetRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.PasswordResetPage();
    },
  );
}

/// generated route for
/// [_i12.ProductDetailsPage]
class ProductDetailsRoute extends _i14.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i15.Key? key,
    required dynamic product,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i12.ProductDetailsPage(
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

  final _i15.Key? key;

  final dynamic product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i13.SignUpPage]
class SignUpRoute extends _i14.PageRouteInfo<void> {
  const SignUpRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.SignUpPage();
    },
  );
}
