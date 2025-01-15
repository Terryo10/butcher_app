import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page , initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: PasswordResetRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: NumberVerificationRoute.page),
        AutoRoute(page: IntroLoginRoute.page),
        AutoRoute(page: LoginOrSignUpRoute.page),
      ];
}
