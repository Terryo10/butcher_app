import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc/auth_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;
  const AppBlocs({super.key, required this.app});

  @override
  Widget build(BuildContext context) {

   return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(),
      ),
    ],
    child: app,
   );
  }
}