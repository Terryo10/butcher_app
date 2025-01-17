import 'package:auto_route/auto_route.dart';
import 'package:butcher_app/ui/auth/login_page.dart';
import 'package:butcher_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../onboarding/onboarding_page.dart';
import '../../state/bloc/cache_bloc/cache_bloc.dart';

@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CacheBloc, CacheState>(
      listener: (context, state) {
       
      },
      child: BlocBuilder<CacheBloc, CacheState>(
        builder: (context, state) {
          if (state is CacheFoundState) {
            return const HomePage();
          } else if (state is CacheNotFoundState) {
            if (state.isAppFirstLaunch) {
              return const OnboardingPage();
            } else {
              return const LoginPage();
            }
          } else if (state is CacheErrorState) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
