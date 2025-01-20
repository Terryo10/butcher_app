import 'package:butcher_app/repositories/auth_repository/auth_repository.dart';
import 'package:butcher_app/repositories/cache_repository/cache_repository.dart';
import 'package:butcher_app/state/bloc/categories_bloc/categories_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/products_repository/products_repository.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/cache_bloc/cache_bloc.dart';
import 'bloc/search_bloc/search_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;
  final FlutterSecureStorage storage;
  const AppBlocs({super.key, required this.app, required this.storage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CacheBloc(
            cacheRepository: RepositoryProvider.of<CacheRepository>(context),
          )..add(
              AppStarted(),
            ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            cacheBloc: BlocProvider.of<CacheBloc>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(
              productsRepository:
                  RepositoryProvider.of<ProductsRepository>(context))
            ..add(GetCategories()),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => SearchBloc(
              productsRepository:
                  RepositoryProvider.of<ProductsRepository>(context)),
          lazy: true,
        ),
      ],
      child: app,
    );
  }
}
