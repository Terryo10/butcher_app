import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/products_repository/products_repository.dart';
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
        BlocProvider(
          create: (context) => CategoriesBloc(
            productsRepository:
                RepositoryProvider.of<ProductsRepository>(context),
          )..add(GetCategories()),
          lazy: false,
        ),
      ],
      child: app,
    );
  }
}
