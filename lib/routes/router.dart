import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: PasswordResetRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: NumberVerificationRoute.page),
        AutoRoute(page: IntroLoginRoute.page),
        AutoRoute(page: LoginOrSignUpRoute.page),
        AutoRoute(page: ProductDetailsRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(page: CheckoutRoute.page),
        AutoRoute(
          page: OrdersListRoute.page,
          path: '/orders',
        ),
        AutoRoute(
          page: OrderDetailsRoute.page,
          path: '/orders/:orderId',
        ),
        AutoRoute(
          page: OrderTrackingRoute.page,
          path: '/orders/:orderId/tracking',
        ),
        AutoRoute(
          page: OrderSuccessRoute.page,
          path: '/order-success',
        ),

        // AutoRoute(page: SideBarRoute.page)
      ];
}
