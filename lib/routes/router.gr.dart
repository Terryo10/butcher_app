// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:butcher_app/core/components/product_details_page.dart' as _i16;
import 'package:butcher_app/models/checkout/checkout_model.dart' as _i20;
import 'package:butcher_app/models/order_model.dart' as _i21;
import 'package:butcher_app/onboarding/onboarding_page.dart' as _i10;
import 'package:butcher_app/ui/auth/forget_password_page.dart' as _i3;
import 'package:butcher_app/ui/auth/intro_login_page.dart' as _i5;
import 'package:butcher_app/ui/auth/login_or_signup_page.dart' as _i7;
import 'package:butcher_app/ui/auth/login_page.dart' as _i8;
import 'package:butcher_app/ui/auth/number_verification_page.dart' as _i9;
import 'package:butcher_app/ui/auth/password_reset_page.dart' as _i15;
import 'package:butcher_app/ui/auth/sign_up_page.dart' as _i17;
import 'package:butcher_app/ui/cart/cart_page.dart' as _i1;
import 'package:butcher_app/ui/cart/checkout_page.dart' as _i2;
import 'package:butcher_app/ui/home_page.dart' as _i4;
import 'package:butcher_app/ui/landing/landing_page.dart' as _i6;
import 'package:butcher_app/ui/profile/order/order_details_page.dart' as _i11;
import 'package:butcher_app/ui/profile/order/order_success.dart' as _i12;
import 'package:butcher_app/ui/profile/order/order_tracking_page.dart' as _i13;
import 'package:butcher_app/ui/profile/order/orders_list_screen.dart' as _i14;
import 'package:flutter/material.dart' as _i19;

/// generated route for
/// [_i1.CartPage]
class CartRoute extends _i18.PageRouteInfo<CartRouteArgs> {
  CartRoute({
    _i19.Key? key,
    bool isHomePage = false,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          CartRoute.name,
          args: CartRouteArgs(
            key: key,
            isHomePage: isHomePage,
          ),
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i18.PageInfo page = _i18.PageInfo(
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

  final _i19.Key? key;

  final bool isHomePage;

  @override
  String toString() {
    return 'CartRouteArgs{key: $key, isHomePage: $isHomePage}';
  }
}

/// generated route for
/// [_i2.CheckoutPage]
class CheckoutRoute extends _i18.PageRouteInfo<void> {
  const CheckoutRoute({List<_i18.PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i2.CheckoutPage();
    },
  );
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordRoute extends _i18.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.IntroLoginPage]
class IntroLoginRoute extends _i18.PageRouteInfo<void> {
  const IntroLoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          IntroLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroLoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.IntroLoginPage();
    },
  );
}

/// generated route for
/// [_i6.LandingPage]
class LandingRoute extends _i18.PageRouteInfo<void> {
  const LandingRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.LandingPage();
    },
  );
}

/// generated route for
/// [_i7.LoginOrSignUpPage]
class LoginOrSignUpRoute extends _i18.PageRouteInfo<void> {
  const LoginOrSignUpRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginOrSignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginOrSignUpRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginOrSignUpPage();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginPage();
    },
  );
}

/// generated route for
/// [_i9.NumberVerificationPage]
class NumberVerificationRoute extends _i18.PageRouteInfo<void> {
  const NumberVerificationRoute({List<_i18.PageRouteInfo>? children})
      : super(
          NumberVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NumberVerificationRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.NumberVerificationPage();
    },
  );
}

/// generated route for
/// [_i10.OnboardingPage]
class OnboardingRoute extends _i18.PageRouteInfo<void> {
  const OnboardingRoute({List<_i18.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i11.OrderDetailsPage]
class OrderDetailsRoute extends _i18.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i19.Key? key,
    required int orderId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            key: key,
            orderId: orderId,
          ),
          rawPathParams: {'orderId': orderId},
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OrderDetailsRouteArgs>(
          orElse: () =>
              OrderDetailsRouteArgs(orderId: pathParams.getInt('orderId')));
      return _i11.OrderDetailsPage(
        key: args.key,
        orderId: args.orderId,
      );
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.orderId,
  });

  final _i19.Key? key;

  final int orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i12.OrderSuccessPage]
class OrderSuccessRoute extends _i18.PageRouteInfo<OrderSuccessRouteArgs> {
  OrderSuccessRoute({
    _i19.Key? key,
    required _i20.OrderResult orderResult,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OrderSuccessRoute.name,
          args: OrderSuccessRouteArgs(
            key: key,
            orderResult: orderResult,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderSuccessRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderSuccessRouteArgs>();
      return _i12.OrderSuccessPage(
        key: args.key,
        orderResult: args.orderResult,
      );
    },
  );
}

class OrderSuccessRouteArgs {
  const OrderSuccessRouteArgs({
    this.key,
    required this.orderResult,
  });

  final _i19.Key? key;

  final _i20.OrderResult orderResult;

  @override
  String toString() {
    return 'OrderSuccessRouteArgs{key: $key, orderResult: $orderResult}';
  }
}

/// generated route for
/// [_i13.OrderTrackingPage]
class OrderTrackingRoute extends _i18.PageRouteInfo<OrderTrackingRouteArgs> {
  OrderTrackingRoute({
    _i19.Key? key,
    required _i21.Order order,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OrderTrackingRoute.name,
          args: OrderTrackingRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderTrackingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderTrackingRouteArgs>();
      return _i13.OrderTrackingPage(
        key: args.key,
        order: args.order,
      );
    },
  );
}

class OrderTrackingRouteArgs {
  const OrderTrackingRouteArgs({
    this.key,
    required this.order,
  });

  final _i19.Key? key;

  final _i21.Order order;

  @override
  String toString() {
    return 'OrderTrackingRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i14.OrdersListPage]
class OrdersListRoute extends _i18.PageRouteInfo<void> {
  const OrdersListRoute({List<_i18.PageRouteInfo>? children})
      : super(
          OrdersListRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersListRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.OrdersListPage();
    },
  );
}

/// generated route for
/// [_i15.PasswordResetPage]
class PasswordResetRoute extends _i18.PageRouteInfo<void> {
  const PasswordResetRoute({List<_i18.PageRouteInfo>? children})
      : super(
          PasswordResetRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordResetRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.PasswordResetPage();
    },
  );
}

/// generated route for
/// [_i16.ProductDetailsPage]
class ProductDetailsRoute extends _i18.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i19.Key? key,
    required dynamic product,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i16.ProductDetailsPage(
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

  final _i19.Key? key;

  final dynamic product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i17.SignUpPage]
class SignUpRoute extends _i18.PageRouteInfo<void> {
  const SignUpRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.SignUpPage();
    },
  );
}
