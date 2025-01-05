import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        // AutoRoute(page: OnboardingRoute.page),
      ];
}
